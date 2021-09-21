# Tips and Tricks for DIaL3

In this section, we describe some of the our experiences that we gained during the technical commissioning of **DIaL3**. These might be useful for the users who are habitual of using either the **DIaL2.5** system or Alice supercomputing facility at UoL. 



## 1. Changes in the Job Scheduler

The scheduler on both the **Alice** and **DIal2.5** is [PBS](https://www.altair.com/pbs-works-documentation/) while on the new DIaL3 system, it is [SLURM](https://slurm.schedmd.com/documentation.html). Thus you will have to change your job submission scripts accordingly. Please see the following section for an example.

## 2. Changes in the Job Submission Script

As we have described above, the new **DIaL3** system uses the  **SLURM** workload manager for submitting jobs to the compute nodes. Suppose that you were running a hybrid job `MPI+OpenMP` on the old system and you want to submit a hybrid job to the new system, you will have to change your script as described below.

#### 2. 1. PBS Script for a hybrid job

```bash
#/bin/bash

#PBS -o stdout_filename.out
#PBS -e stderr_filename.error
#PBS -N your_job_name
#PBS -l nodes=2:ppn=36
#PBS -l walltime=01:00:00
#PBS -m bea
#PBS -A account_name

# Load requires modules
module purge
module load intel/compilers/20.1
module load intel/mpi/20.1

#Change to current directory.
cd $PBS_O_WORKDIR

YOUR_EXECUTABLE_DIR=/home/your_executable_dir
MY_CURRENT_HOME=.
INPUT_FILENAME=setup.txt

# This is an input to the run command. You might not need this.
Stage1_run=initial

# An input file for the run. You might not need this.
Bin_file_name=ifile

Number_omp_threads_per_mpi_process=4
Number_mpi_process_per_node=9

#Total number of mpi process = number of nodes * number of mpi processes per node
Total_number_mpi_process=18

Ouput_file_name=log_file.out 

export OMP_NUM_THREADS=$Number_omp_threads_per_mpi_process

mpirun -perhost $Number_mpi_process_per_node -n $Total_number_mpi_process $YOUR_EXECUTABLE_DIR/YOUR_EXECUTABLE $Stage1_run $Bin_file_name < $INPUT_FILENAME &> $Ouput_file_name
```

####  2.2. SLURM script for a hybrid job

```bash
#!/bin/bash --login

#SBATCH -J Your_Job_Name
#SBATCH -o Your_stdout_filename.o%j
#SBATCH -e Your_stderr_filename.e%j
##SBATCH -p Partition_name
##SBATCH -A Account_name
#SBATCH --nodes=2
#SBATCH --ntasks=16
#SBATCH --ntasks-per-node=8
#SBATCH --exclusive
#SBATCH -t 00:30:00


export nodecnt=$SLURM_JOB_NUM_NODES
export corecnt=`expr ${SLURM_CPUS_ON_NODE} \* ${nodecnt}`
export mpicnt=$SLURM_NTASKS
export threadspermpi=`expr ${SLURM_CPUS_ON_NODE} \/ ${SLURM_NTASKS_PER_NODE}`
export threadcnt=`expr ${mpicnt} \* ${threadspermpi}`
export OMP_NUM_THREADS=$threadspermpi
#export I_MPI_PIN_DOMAIN=omp
export OMP_PLACES=cores


if [ $threadcnt -ne $corecnt ]
then
  echo "Error, mismatch between requested and available hardware!"
  exit -1
fi

#Dial3 modules. Please modify accordingly.
module purge
module load intel-parallel-studio/cluster.2019.5


#Define paths for locating the executable.
export EXE_DIR=/home/your_executable_directory
export RESULTS_HOME=/home/n$SLURM_JOB_NUM_NODES
cd $RESULTS_HOME


mpirun -n $SLURM_NTASKS -ppn $SLURM_NTASKS_PER_NODE $EXE_DIR/your_executable initial ifile < $RESULTS_HOME/setup.txt &> sphng_setup.o
```

## 3. Loading of modules

During the technical commissioning phase, we found that some users were loading modules in a sequence such that second module was interfering with the first module. As for example, suppose that you want to use `Intel` compilers, then it is sufficient to use the following module

```bash
$ module load intel-parallel-studio/cluster.2019.5
```

If you plan to use one API compilers, then it is not a good idea to load one API compiler first and then load the parallel studio. For example the following will not give you the desired result as the second module load `Intel-parallel-studio` may over ride the first one i.e. `intel-oneapi-compilers`. 

```bash
$ module load intel-oneapi-compilers/2021.2.0/3q6eev
$ module load intel-parallel-studio/cluster.2019.5/aveeft
```

## 4. Some common and useful module combinations

In this section, we present a brief combination of some of the useful module combinations that our users asked us during the technical commissioning. 

#### 4. 1. Intel Compiler + Intel MPI

```bash
$ module load intel-parallel-studio/cluster.2019.5/aveeft
```

#### 4.2. Intel One API compiler and Intel One API MPI

```bash
$ module load intel-oneapi-compilers/2021.2.0/3q6eev
$ module load intel-oneapi-mpi/2021.2.0/jjwa2o
```

#### 4.3. AMD AOCC compiler and OpenMPI

```bash
$ module load aocc/3.0.0
$ module load openmpi/4.0.5
```

#### 4.4. Intel Compilers 2021 and OpenMPI

```bash
$ module load intel-oneapi-compilers/2021.2.0
$ module load openmpi4/intel/4.0.5
```

## 5. Suggested Compiler Flags

#### 5. 1. Intel

In order to use the Intel compilers optimally on the  new **DIaL3** system consisting of **AMD EPYC** processors, we suggest the following flags.

| Compiler                   | Suggested Flags                                              |
| -------------------------- | ------------------------------------------------------------ |
| **Intel C Compiler**       | *-O3 -march=core-avx2 -fma -ftz -fomit-frame-pointer*        |
| **Intel C++ Compiler**     | *-O3 -march=core-avx2 -fma -ftz -fomit-frame-pointer*        |
| **Intel Fortran Compiler** | *-O3 -march=core-avx2 -align array64byte -fma -ftz -fomit-frame-pointer* |

#### 5.2. GNU 

| Compiler              | Suggested Flags                                              |
| --------------------- | ------------------------------------------------------------ |
| **gcc compiler**      | *-O3 -march=znver1 -mtune=znver1 -mfma -mavx2 -m3dnow -fomit-frame-pointer* |
| **g++ compiler**      | *-O3 -march=znver1 -mtune=znver1 -mfma -mavx2 -m3dnow -fomit-frame-pointer* |
| **gfortran compiler** | *-O3 -march=znver1 -mtune=znver1 -mfma -mavx2 -m3dnow -fomit-frame-pointer* |

#### 5.3. AOCC

| Compiler                   | Suggested Flags                                              |
| -------------------------- | ------------------------------------------------------------ |
| **clang compiler**         | *-O3 -march=znver1 -mfma -fvectorize -mfma -mavx2 -<br/>m3dnow -floop-unswitch-aggressive -fuse-ld=lld* |
| **clang++ compiler**       | *-O3 -march=znver1 -mfma -fvectorize -mfma -mavx2 -m3dnow -fuse-ld=lld* |
| **Fortran clang compiler** | *-O3 -mavx -fplugin-arg-dragonegg-llvm-codegen-op-<br/>timize=3 -fplugin-arg-dragonegg-llvm-ir-optimize=3* |

Please be advised that the suggested compiler flags are general based on the **AMD EPYC** processors. They may or may not work for you.



## 6. Flags and modules tested during Technical Commissioning

HPE suggested us to use some flags for the benchmarks that were used for checking the system performance and for procurement. On **DIaL3**, we tested 3 applications. We present the optimal combination of module and flags that we used for compilation and execution below.

Note: We need to take permissions before mentioning the application name. Hence, the name of the application is not mentioned below.

#### 6.1. Application 1

###### Modules used

```bash
$ module load intel-oneapi-compilers 
$ module load openmpi4/intel/4.0.5 
```

###### Flags used

```bash
#Compiler/Wrapper name
F90 = mpif90

#Flags used
FFLAGS = -cpp -assume buffered_io -march=core-avx2 -align array64byte -fma -ftz -fomit-frame-pointer -O3 -ip -free
```

#### 6.2. Application 2

###### Modules used

```bash
$ module load intel-parallel-studio/cluster.2019.5 
```

###### Flags used

```bash
#Compiler/Wrapper name
F90 = mpiifort

#Flags used
FFLAGS= -O3 -mavx2 -mfma -mcmodel=medium \
            -warn uninitialized -warn truncated_source\
            -warn interfaces -nogen-interfaces
```

#### 6.3. Application 3

###### Modules used

```bash
$ module load intel-parallel-studio/cluster.2019.5
```

###### Flags used

```bash
#Compiler/Wrapper name
F90 = mpiifort

#Flags used
FFLAGS= -qopenmp -mavx2 -mfma  -O3 -ip -Ofast
```

