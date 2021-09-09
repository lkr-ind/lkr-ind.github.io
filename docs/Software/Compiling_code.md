# Compiling Code On DIaL3

If you want to compile your code on DIaL3, there are two compilers available for C, C++ and Fortran: the Intel compilers and the GNU Compiler Collection (GCC).

Below we give a list of compilers for various languages:

#### Compiler names for various languages

| Language      | GCC        | Intel   |
| ------------- | ---------- | ------- |
| C             | `gcc`      | `icc`   |
| C++           | `g++`      | `icpc`  |
| F77, F90, F95 | `gfortran` | `ifort` |

### How to load a particular Compiler?

You can either load the GCC or Intel compilers by using the `module load` command. For GCC compilers, you can use something like:

```bash
$ module load  gcc/9.3.0
```

and for Intel compilers, you can use:

```bash
$ module load intel-parallel-studio/cluster.2019.5
```

The Intel Parallel Studio Cluster module gives you many things in addition to the default `icc`, `icpc`  and `ifort` compilers. It also provides you with tools such as Vtune (Debugger), ITAC (Intel Trace Analyser and Collector) etc.

### How to compile your Serial code?

Once you have loaded a suitable compiler, you can compile your serial code using one of the following commands.

a. For C Code

```bash
# If you are using GCC compiler
$ gcc my_serial_code.c -o my_binary_file_name.o

# If you are using Intel compiler
$ icc my_serial_code.c -o my_binary_file_name.o
```

b. For C++ Code

```bash
# If you are using GCC compiler
$ g++ my_serial_code.cpp -o my_binary_file_name.o

# If you are using Intel compiler
$ icpc my_serial_code.cpp -o my_binary_file_name.o
```

c. For Fortran Code

```bash
# If you are using GCC compiler
$ gfortran my_serial_code.f90 -o my_binary_file_name.o

# If you are using Intel compiler
$ ifort my_serial_code.f90 -o my_binary_file_name.o
```

### How to compile your OpenMP code?

Many scientific codes use more than one cores available on one single node of a HPC system in order to reduce the computational time. In most cases, OpenMP is the default choice for thread based parallelism or shared memory programming. In order to compile your OpenMP code, all you need to add is additional flag during the compilation stage which is `-fopenmp` for GCC compilers and `-qopenmp` for Intel compilers. 

After loading your compiler, you can compile your OpenMP code using one of the following commands.

a. For C Code

```bash
# If you are using GCC compiler
$ gcc -fopenmp my_openmp_code.c -o my_binary_file_name.o

# If you are using Intel compiler
$ icc -qopenmp my_openmp_code.c -o my_binary_file_name.o
```

b. For C++ Code

```bash
# If you are using GCC compiler
$ g++ -fopenmp my_openmp_code.cpp -o my_binary_file_name.o

# If you are using Intel compiler
$ icpc -qopenmp my_openmp_code.cpp -o my_binary_file_name.o
```

c. For Fortran Code

```bash
# If you are using GCC compiler
$ gfortran -fopenmp my_openmp_code.f90 -o my_binary_file_name.o

# If you are using Intel compiler
$ ifort -qopenmp my_openmp_code.f90 -o my_binary_file_name.o
```

### How to compile your MPI code?

Message Passing Interface or MPI is the default application programming interface (API) used in the HPC software development for using more than one node on the system. It allows you to communicate between tasks by sharing messages between them.

To compile your MPI code, first load a compiler of your choice and then use one of the following commands.

a. For C Code

```bash
# If you are using GCC compiler
$ mpicc my_mpi_code.c -o my_binary_file_name.o

# If you are using Intel compiler
$ mpiicc my_mpi_code.c -o my_binary_file_name.o
```

b. For C++ Code

```bash
# If you are using GCC compiler
$ mpicxx my_mpi_code.cpp -o my_binary_file_name.o

# If you are using Intel compiler
$ mpiicpc my_mpi_code.cpp -o my_binary_file_name.o
```

c. For Fortran Code

```bash
# If you are using GCC compiler
$ mpif90 my_mpi_code.f90 -o my_binary_file_name.o

# If you are using Intel compiler
$ mpiifort my_mpi_code.f90 -o my_binary_file_name.o
```

### How to compile code with Debug or Optimisation flags?

All the command that are given above can also be used by using additional flags either for debugging purpose or for Optimisation. The following table lists some basic options:

| Options | Function                                                     |
| ------- | ------------------------------------------------------------ |
| -g      | Enables debugging information.                               |
| -Ox     | Enables compiler optimization, where `X` represents the optimization level and is one of 0, 1, 2, 3. |

An example usage of an optimisation flag is given below:

```bash
$ icc -O3 my_code.c -o my_binary_file.o 
```

