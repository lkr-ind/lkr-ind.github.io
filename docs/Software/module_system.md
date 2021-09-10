# Software Module System

Like most HPC sites, We use modulefiles to manage software on DIaL3.  However, we are also heirerachical 

The main command for using this system is called the `module` command. To get a list of all options available with this command, you can type:

```bash
$ module --help
```

## Which all modules are available?

To see a list of all modules installed on DIaL3, use the command:

```bash
$ module avail
```

For more details, please see [List of all modules](./software_installed.md)

## Which modules are currently loaded?

To see the list of module currently loaded in your environment, please use the command:

```bash
$ module list
```

## How to load a module?

To load a module, type the following in you terminal:

```bash
$ module load gcc
```

This will load the default `gcc` version (*gcc/10.2.0 in this case*) in your environment. To load a particular version, please use:

```bash
$ module load gcc/11.1.0/xu5zmz
```

## How to unload a module?

To unload a module, please use the following:

```bash
$ module unload gcc/11.1.0/xu5zmz
```

## How to see which all environment variables are modified by loading a module?

To get more details about all the environmental variables that are added or modified by loading a module, please use the either of the two commands `module display gcc` or `module show gcc`. For example, if you type the following in your terminal,

```bash
$ module display gcc
```

You will get an output similar to the following:

```bash
----------------------------------------------------------------------------
   /cm/local/modulefiles/gcc/10.2.0:
----------------------------------------------------------------------------
whatis("adds GNU Cross Compilers to your environment variables ")
prepend_path("PATH","/cm/local/apps/gcc/10.2.0/bin")
prepend_path("LD_LIBRARY_PATH","/cm/local/apps/gcc/10.2.0/lib:/cm/local/apps/gcc/10.2.0/lib64:/cm/local/apps/gcc/10.2.0/lib32")
help([[ Adds GNU Cross Compilers to your environment variables,
]])

```

From above output, it can be clearly seen that the `gcc` module adds values to the `PATH` and `LD_LIBRARY_PATH` variables.

## How to switch to a different version of a module?

To switch to a different version of a module, you can use the `module switch older_version new_version` command as shown below.

```bash
$ module switch gcc gcc/11.1.0 
```

## How to unload all modules? 

To remove all modules from your environment, please use the following command.

```bash
$ module purge
```

