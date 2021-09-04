# Arm Forge

Arm forge is one of the leading HPC and server development tools used in research, academia and industry for high performance codes written either in C, C++, Fortran or Python. Arm forge has three major components:-

1. [Arm Performance Reports](./Perf_report.md)
2. [Arm MAP](./Profile_code.md)
3. [Arm DDT](./Debug_code.md)

To use Arm forge on DiAL3, please load the Arm forge module by the following command.

`module load arm/forge/21.0.2 `.

You can use Arm forge in two different ways:-

1. Using X forwarding (might be slow)
2. By installing Arm forge on your local computer (No License needed).

## Use Arm Forge by X forwarding

First login to DiAL3 cluster by using the following command (please pay attention to the -X flag in the command).

```bash
$ ssh -X your_username@dial3.dirac.ac.uk 
```

Enter your password to login. Once you have logged in, load the Arm forge module by entering the following command in the terminal.

```bash
$ module load arm/forge/21.0.2
```

To see what all paths and variables have been added to your environment by the above load command, type the following.

```bash
$ module display arm/forge/21.0.2
```

This will show the following output on your screen.

```bash
----------------------------------------------------------------------------
   /cm/shared/modulefiles/arm/forge/21.0.2:
----------------------------------------------------------------------------
whatis("Loads the ARM Forge - MPI profiler and debugger (21.0.2) software environment ")
prepend_path("PATH","/cm/shared/apps/arm/forge/21.0.2/bin")
prepend_path("LIBRARY_PATH","/cm/shared/apps/arm/forge/21.0.2/lib")
prepend_path("LD_RUN_PATH","/cm/shared/apps/arm/forge/21.0.2/lib")
prepend_path("CPATH","/cm/shared/apps/arm/forge/21.0.2/lib")
setenv("ARM_LICENSE_DIR","/cm/shared/apps/arm/forge/21.0.2/licences")
help([[  forge/21.0.2 - loads the ARM Forge - MPI profiler and debugger (21.0.2) software environment

]])
```

If you see the first entry in the prepend path, you will see the location where all binaries of arm forge are located. Change to that directory to see what all binaries are there.

```bash
$ cd /cm/shared/apps/arm/forge/21.0.2/bin

#List the contents of that directory.
$ ls
allinea-client  ddt-mpirun    forge-mpirun             map
ddt             forge         forge-probe              perf-report
ddt-client      forge-client  make-profiler-libraries

#Open the forge GUI by using the following command. 
$ ./forge

```

Now you can use this GUI to [debug your code](./Debug_code.md) or [view profile reports](./Profile_code.md).

## USE Arm forge by Installing on your PC

You can also use Arm forge by first installing it on your PC (you do not need a license for that) and using that to view your code profile. For more details, please click [Install Arm Forge](./Install_arm_forge.md).