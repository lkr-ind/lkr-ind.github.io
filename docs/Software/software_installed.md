# Software Installed on DIaL3 

To view the list of all software installed on DIaL3, please use the following command.

```bash
$ module avail
```

This will produce an output similar to the one given below.

```bash
----------------------------------------------------------------------------------------------------------- /cm/local/modulefiles ------------------------------------------------------------------------------------------------------------
   boost/1.74.0         cm-bios-tools    cmjob    freeipmi/1.6.6        ipmitool/1.8.18    luajit          module-git     null        python3     shared
   cluster-tools/9.1    cmd              dot      gcc/10.2.0     (L)    lua/5.4.0          mariadb-libs    module-info    openldap    python37

----------------------------------------------------------------------------------------------------------- /cm/shared/modulefiles -----------------------------------------------------------------------------------------------------------
   arm/forge/21.0.2                   cm-pmix3/3.1.4                globalarrays/openmpi/gcc/64/5.7    hwloc/1.11.11                        (L)    lapack/gcc/64/3.9.0           netperf/2.7.0             openmpi/intel/64/1.10.7
   blacs/openmpi/gcc/64/1.1patch03    default-environment           hdf5/1.10.1                        intel-cluster-runtime/ia32/2018.4           mpich/ge/gcc/64/3.3.2         openblas/dynamic/0.3.7    openmpi4/intel/4.0.5
   blas/gcc/64/3.8.0                  fftw3/openmpi/gcc/64/3.3.8    hdf5_18/1.8.21                     intel-cluster-runtime/intel64/2018.4 (D)    mvapich2/gcc/64/2.3.4         openmpi/gcc/64/1.10.7     ucx/1.8.1
   bonnie++/1.98                      gdb/9.2                       hpl/2.3                            iozone/3_490                                netcdf/gcc/64/gcc/64/4.7.3    openmpi/intel/4.1.1

------------------------------------------------------------------------------------------- /cm/shared/spack/modulefiles/linux-centos8-x86_64/Core -------------------------------------------------------------------------------------------
   aocc/3.0.0/khmpxw      git/2.31.1/5gqme4                           (D)    libyaml/0.2.5/munqv6                py-astropy/4.0.1.post1/y7idi7    py-pip/20.2/dpkoc3             py-six/1.15.0/qdn5ig        subversion/1.14.0/phet6w
   cfitsio/3.49/bz5el3    gmp/6.2.1/duarub                                   mpc/1.1.0/gq23h3                    py-attrs/20.3.0/gdqkh2           py-pybind11/2.5.0/2u5jvb       py-urllib3/1.25.6/jteu6y    utf8proc/2.4.0/z2q6eq
   erfa/1.7.0/tglix3      go/1.16.3/vluwso                                   mpc/1.1.0/qjhl6d             (D)    py-certifi/2020.6.20/3sawz2      py-pyrsistent/0.15.7/2rz44t    python/3.8.10/k3bk3z        wcslib/7.3/qlpvcj
   gcc/10.1.0/jc4hra      intel-oneapi-compilers/2021.2.0/3q6eev             mpfr/3.1.6/gp2hzx                   py-chardet/3.0.4/224gjx          py-pyyaml/5.3.1/dabygq         reframe/3.6.0/uybl7o        zstd/1.5.0/smjvvt
   gcc/10.3.0/picedk      intel-parallel-studio/cluster.2019.5/aveeft        mpfr/4.1.0/5s7ta5                   py-idna/2.8/zbo4e6               py-requests/2.24.0/g5snxt      shadow/4.8.1/uh7fcd
   gcc/11.1.0/xu5zmz      json-c/0.15/gl7632                                 openblas/0.3.15/lgxqon              py-jsonschema/3.2.0/gch7xg       py-scipy/1.6.3/6oolhg          singularity/3.7.2/s3zh3a
   gcc/9.3.0/jxhhag       libgcrypt/1.9.1/mqhgzp                             popt/1.16/jbnhdc                    py-lxml/4.6.1/5dwx7l             py-semver/2.8.1/hvljd6         slurm/20.11/4tobjv
   git/2.31.1/uqsg2n      libxslt/1.1.33/67rmne                              py-argcomplete/1.12.0/bdomkm        py-numpy/1.20.3/koxiyg           py-setuptools/50.3.2/huv7bg    squashfs/4.4/h6onej

  Where:
   L:  Module is loaded
   D:  Default Module

Module defaults are chosen based on Find First Rules due to Name/Version/Version modules found in the module tree.
See https://lmod.readthedocs.io/en/latest/060_locating.html for details.

Use "module spider" to find all possible modules and extensions.
Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".

```

## Search for a module

There are two ways by which you can search for a particular module of your interest.

1. Using `module avail` directly
2. Using `spider` command

### Using module avail to search a module

Let us say that you want to search for all modules having `intel` word in their name. You can use the following command in your terminal.

```bash
$ module avail intel
```

This will give you the following output.

```bash
---------------------------- /cm/shared/modulefiles ----------------------------
   intel-cluster-runtime/ia32/2018.4           openmpi/intel/64/1.10.7
   intel-cluster-runtime/intel64/2018.4 (D)    openmpi4/intel/4.0.5
   openmpi/intel/4.1.1

------------ /cm/shared/spack/modulefiles/linux-centos8-x86_64/Core ------------
   intel-oneapi-compilers/2021.2.0/3q6eev
   intel-parallel-studio/cluster.2019.5/aveeft

  Where:
   D:  Default Module

Module defaults are chosen based on Find First Rules due to Name/Version/Version modules found in the module tree.
See https://lmod.readthedocs.io/en/latest/060_locating.html for details.

Use "module spider" to find all possible modules and extensions.
Use "module keyword key1 key2 ..." to search for all possible modules matching
any of the "keys".
```

As you can see in the output, you got all modules with the name `intel` in them but it also produced some extra lines at the end. In order to further refine the output, you can use `grep` command in conjunction with `module avail` as shown below.

```bash
$ module avail 2>&1 | grep -i intel
```

The above command will produce the output as shown below.

```bash
   intel-cluster-runtime/ia32/2018.4
   intel-cluster-runtime/intel64/2018.4 (D)
   openmpi/intel/4.1.1
   openmpi/intel/64/1.10.7
   openmpi4/intel/4.0.5
   intel-oneapi-compilers/2021.2.0/3q6eev
   intel-parallel-studio/cluster.2019.5/aveeft
```



### Using spider to search a module 

You can also use spider to search a module as shown below.

```bash
$ module spider intel
```

This will show an output similar to what is shown below.

```bash
----------------------------------------------------------------------------
  intel-cluster-runtime:
----------------------------------------------------------------------------
     Versions:
        intel-cluster-runtime/ia32/2018.4
        intel-cluster-runtime/intel64/2018.4

----------------------------------------------------------------------------
  For detailed information about a specific "intel-cluster-runtime" package (including how to load the modules) use the module's full name.
  Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider intel-cluster-runtime/intel64/2018.4
----------------------------------------------------------------------------

----------------------------------------------------------------------------
  intel-oneapi-compilers/2021.2.0: intel-oneapi-compilers/2021.2.0/3q6eev
----------------------------------------------------------------------------
    This module can be loaded directly: module load intel-oneapi-compilers/2021.2.0/3q6eev

    Help:
      Intel OneAPI compilers Provides Classic and Beta compilers for: Fortran,
      C, C++

----------------------------------------------------------------------------
  intel-oneapi-mkl/2021.2.0: intel-oneapi-mkl/2021.2.0/gbymet
----------------------------------------------------------------------------
    You will need to load all module(s) on any one of the lines below before the "intel-oneapi-mkl/2021.2.0/gbymet" module is available to load.

      intel-oneapi-compilers/2021.2.0/3q6eev
 
    Help:
      Intel oneAPI MKL.

----------------------------------------------------------------------------
  intel-oneapi-mpi/2021.2.0: intel-oneapi-mpi/2021.2.0/jjwa2o
----------------------------------------------------------------------------
    You will need to load all module(s) on any one of the lines below before the "intel-oneapi-mpi/2021.2.0/jjwa2o" module is available to load.

      intel-oneapi-compilers/2021.2.0/3q6eev
 
    Help:
      Intel oneAPI MPI.

----------------------------------------------------------------------------
  intel-oneapi-tbb/2021.2.0: intel-oneapi-tbb/2021.2.0/lv2dqa
----------------------------------------------------------------------------
    You will need to load all module(s) on any one of the lines below before the "intel-oneapi-tbb/2021.2.0/lv2dqa" module is available to load.

      intel-oneapi-compilers/2021.2.0/3q6eev
 
    Help:
      Intel oneAPI TBB.

----------------------------------------------------------------------------
  intel-parallel-studio/cluster.2019.5: intel-parallel-studio/cluster.2019.5/aveeft
----------------------------------------------------------------------------
    This module can be loaded directly: module load intel-parallel-studio/cluster.2019.5/aveeft

    Help:
      Intel Parallel Studio.

----------------------------------------------------------------------------
  openmpi/intel/4.1.1: openmpi/intel/4.1.1
----------------------------------------------------------------------------
    You will need to load all module(s) on any one of the lines below before the "openmpi/intel/4.1.1" module is available to load.

      shared
 
    Help:
        Adds OpenMPI to your environment variables,
      
----------------------------------------------------------------------------
  openmpi/intel/64: openmpi/intel/64/1.10.7
----------------------------------------------------------------------------

    You will need to load all module(s) on any one of the lines below before the "openmpi/intel/64/1.10.7" module is available to load.

      shared
 
    Help:
        Adds OpenMPI to your environment variables,
      
----------------------------------------------------------------------------
  openmpi4/intel: openmpi4/intel/4.0.5
----------------------------------------------------------------------------
    You will need to load all module(s) on any one of the lines below before the "openmpi4/intel/4.0.5" module is available to load.

      shared
 
    Help:
        Adds OpenMPI 4 to your environment variables,

```

