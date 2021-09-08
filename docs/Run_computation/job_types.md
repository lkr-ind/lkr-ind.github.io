# Job types

There are various types of jobs that you can run on DIaL3 such as:-

1. **Array jobs**
2. **OpenMP jobs**
3. **MPI jobs**
4. **Hybrid MPI/OpenMP jobs**

We first start with a basic script explaining some details and then we present the specific example scripts of various jobs types mentioned above.

## Basic Job Script

A basic job script on DiAL3 would look like the following.

```bash
#!/bin/bash -l

##############################
#   BASIC JOB SCRIPT         #
##############################

# Define your job name here so that you can recognise it in the queue.
#SBATCH --job-name=example

# Define the output file name (%j at end will append the job id at the end of the name). This will store the standard output 'stdout' for the job. 
#SBATCH -o your_output_file_name%j

# Define file name for storing any errors (stderr). 
#SBATCH -e your_error_file_name%j

# Define the partition on which you want to run.
#SBATCH -p partition_name

# Define the Account/Project name from which the computation would be charged. 
#SBATCH -A your_Account_name

# Define, how many nodes you need. Here, we ask for 1 node. Each node has 128 CPU cores.
#SBATCH --nodes=1
# You can further define the number of tasks with --ntasks-per-*
# See "man sbatch" for details. e.g. --ntasks=4 will ask for 4 cpus.

# Define, how long the job will run in real time. This is a hard cap meaning
# that if the job runs longer than what is written here, it will be
# force-stopped by the server. If you make the expected time too long, it will
# take longer for the job to start. Here, we say the job will take 1 hour.
# hh:mm:ss
#SBATCH --time=01:00:00

# How much memory you need.
# --mem will define memory per node and
# --mem-per-cpu will define memory per CPU/core. Choose one of those.
#SBATCH --mem-per-cpu=1500MB
##SBATCH --mem=5GB    # this one is not in effect, due to the double hash

# Turn on mail notification. There are many possible self-explaining values:
# NONE, BEGIN, END, FAIL, ALL (including all aforementioned)
# For more values, check "man sbatch"
#SBATCH --mail-type=END,FAIL

# You may not place any commands before the last SBATCH directive

# Define and create a unique scratch directory for this job
SCRATCH_DIRECTORY=/scratch/Your_project/${USER}/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}

# You can copy everything you need to the scratch directory
# ${SLURM_SUBMIT_DIR} points to the path where this script was submitted from
cp ${SLURM_SUBMIT_DIR}/myfiles*.txt ${SCRATCH_DIRECTORY}

# This is where the actual work is done. In this case, the script only waits.
# The time command is optional, but it may give you a hint on how long the
# command worked
time sleep 10

# After the job is done we copy our output back to $SLURM_SUBMIT_DIR
cp ${SCRATCH_DIRECTORY}/my_output ${SLURM_SUBMIT_DIR}

# After everything is saved to the home directory, delete the work directory to
# save space on /scratch
cd ${SLURM_SUBMIT_DIR}
rm -rf ${SCRATCH_DIRECTORY}

# Finish the script
exit 0
```

Please note that the above script does not contain any `module load ` command as it is a very simple and basic example. In many cases, you would need to load certain modules or compilers such as `ifort`, `icpc`, `gcc`,  `g++` etc. Please see the examples given below to see how to add module load statements in the job submission scripts.

## Array jobs

An array job lets you submit the same job dozens or even hundreds of times with different inputs. This is a lot quicker than manually submitting the job multiple times.

In this example the serial job **mycode.exe** will be submitted 10  times. Each job is still a serial job requesting only one processor  core, but 10 instances will be queued. The `sbatch` option for creating an array job is `--array`:

```bash
#SBATCH --array=1-10
```

Each instance of the job gets a job ID as usual, but also an array task ID. This is available within the environment variable `SLURM_ARRAY_TASK_ID`, and can be used within the script or program code to derive input values for the jobs. 

A sample submission script based on the above is given below.

```bash
#!/bin/bash --login

#SBATCH -J your_job_name
#SBATCH -o output_file_name%j
#SBATCH -e error_file_name%j
#SBATCH -p partition_name
#SBATCH -A account_name
#SBATCH --nodes=1
#SBATCH -t 00:30:00

# 16 jobs will run in this array at the same time
#SBATCH --array=1-10

# each job will see a different ${SLURM_ARRAY_TASK_ID}
echo "now processing task id:: " ${SLURM_ARRAY_TASK_ID}

# Execute your serial job code
/path_to_my_code.exe > output_${SLURM_ARRAY_TASK_ID}
```

## OpenMP jobs

```bash
#!/bin/bash -l

#############################
# example for an OpenMP job #
#############################

#SBATCH --job-name=your_job_name
#SBATCH -o output_file_name%j
#SBATCH -e error_file_name%j
#SBATCH -p partition_name
#SBATCH -A account_name

# we ask for 1 task with 90 cores
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=90

# exclusive makes the entire node available to your job only.
#SBATCH --exclusive

# run for ten minutes hh:mm:ss
#SBATCH --time=00:10:00

# turn on all mail notification
#SBATCH --mail-type=ALL

# Remove all previously loaded modules.
module purge

# Load your desired modules here.
module load intel-parallel-studio/cluster.2019.5
module load arm/forge/21.0.2

# define and create a unique scratch directory
SCRATCH_DIRECTORY=/scratch/Your_project/${USER}/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}

# we copy everything we need to the scratch directory
# ${SLURM_SUBMIT_DIR} points to the path where this script was submitted from
cp ${SLURM_SUBMIT_DIR}/my_binary.x ${SCRATCH_DIRECTORY}

# we set OMP_NUM_THREADS to the number of available cores
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

# we execute the job and time it
time ./my_binary.x > my_output

# after the job is done we copy our output back to $SLURM_SUBMIT_DIR
cp ${SCRATCH_DIRECTORY}/my_output ${SLURM_SUBMIT_DIR}

# we step out of the scratch directory and remove it
cd ${SLURM_SUBMIT_DIR}
rm -rf ${SCRATCH_DIRECTORY}

# Finish the script and Exit. 
exit 0
```

## MPI jobs

```bash
#!/bin/bash -l

##########################
# example for an MPI job #
##########################

#SBATCH --job-name=your_job_name
#SBATCH -o output_file_name%j
#SBATCH -e error_file_name%j
#SBATCH -p partition_name
#SBATCH -A account_name

# We ask for two nodes.
#SBATCH --nodes=2

# 200 MPI tasks in total
#SBATCH --ntasks=200

# We ask for 100 task on each node.
#SBATCH --ntasks-per-node=100

# run for one hour and thrity minutes hh:mm:ss
#SBATCH --time=01:30:00

# 500MB memory per core
# this is a hard limit
#SBATCH --mem-per-cpu=500MB

# turn on all mail notification
#SBATCH --mail-type=ALL

# Remove all previously loaded modules.
module purge

# Load your desired modules here.
module load intel-parallel-studio/cluster.2019.5
module load arm/forge/21.0.2

# define and create a unique scratch directory
SCRATCH_DIRECTORY=/scratch/Your_project/${USER}/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}

# we copy everything we need to the scratch directory
# ${SLURM_SUBMIT_DIR} points to the path where this script was submitted from
cp ${SLURM_SUBMIT_DIR}/my_binary.x ${SCRATCH_DIRECTORY}

# we execute the job and time it
time mpirun -np $SLURM_NTASKS ./my_binary.x > my_output

# after the job is done we copy our output back to $SLURM_SUBMIT_DIR
cp ${SCRATCH_DIRECTORY}/my_output ${SLURM_SUBMIT_DIR}

# we step out of the scratch directory and remove it
cd ${SLURM_SUBMIT_DIR}
rm -rf ${SCRATCH_DIRECTORY}

# Finish the script and Exit.
exit 0
```

## Hybrid MPI/OpenMP jobs

```bash
#!/bin/bash -l

#######################################
# example for a hybrid MPI OpenMP job #
#######################################

#SBATCH --job-name=your_job_name
#SBATCH -o output_file_name%j
#SBATCH -e error_file_name%j
#SBATCH -p partition_name
#SBATCH -A account_name

# we ask for 8 MPI tasks with 10 cores each
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=10

# run for fifteen minutes hh:mm:ss
#SBATCH --time=00:15:00

# 500MB memory per core
# this is a hard limit
#SBATCH --mem-per-cpu=500MB

# turn on all mail notification
#SBATCH --mail-type=ALL

# Remove all previously loaded modules.
module purge

# Load your desired modules here.
module load intel-parallel-studio/cluster.2019.5
module load arm/forge/21.0.2

# define and create a unique scratch directory
SCRATCH_DIRECTORY=/scratch/Your_project/${USER}/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}

# we copy everything we need to the scratch directory
# ${SLURM_SUBMIT_DIR} points to the path where this script was submitted from
cp ${SLURM_SUBMIT_DIR}/my_binary.x ${SCRATCH_DIRECTORY}

# we set OMP_NUM_THREADS to the number cpu cores per MPI task
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

# we execute the job and time it
time mpirun -np $SLURM_NTASKS ./my_binary.x > my_output

# after the job is done we copy our output back to $SLURM_SUBMIT_DIR
cp ${SCRATCH_DIRECTORY}/my_output ${SLURM_SUBMIT_DIR}

# we step out of the scratch directory and remove it
cd ${SLURM_SUBMIT_DIR}
rm -rf ${SCRATCH_DIRECTORY}

# Finish the script and Exit.
exit 0
```

