# Software Module System

Since DIaL3 is a shared resource used by many researchers, students and academicians, the Research Computing Services (RCS) team provides some centrally installed software for all users. This allows two major advantages:-

1. It allows for easier support and maintenance of the software as the user cannot change the default settings in a centrally installed software.
2. A user is relieved of installing a software by himself as many of the most widely used software have already been installed for them and are ready to be used.

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

