# Python

[Python](https://www.python.org/) is a high level programming language. It is an interpreted language as compared to compile type languages like C, C++ or Fortran. It is also an Object Oriented Language which allows programmers to write clear and logical code for various types of projects. It is also one of the most widely use languages in the field of Data Science, Machine Learning and Artificial Intelligence.

To use Python on DIaL3, you can use one of the available modules such as the following:

```bash
$ module load python3
```

To see the exact version of Python in your environment, use the following

```bash
$ python --version
```

 It might happen that you need additional packages and libraries for Python that are not there on DIaL3. You can install them using any of the following methods:-

1. Using Pip to Install a package in your home directory
2. Using Virtual Environment
3. Using Conda

We describe each method in more detail below.

### Using Pip to Install a package in your home directory

If you want to install a package in your home directory, you can use the following command

```bash
$ pip install --user package_name
```

where `--user` is responsible for installing the package in your home directory. Although this method is quite simple, it might lead to conflicts if you want to install multiple packages which might not be compatible with each other. The best way to handle such situation is to install separate compatible packages in their own environment. This can be done either using Virtual Environment or Using conda.

### Virtual environment

A python virtual environment installs a python environment (and a default set of libraries) into a directory you specify. This makes it simple to use pip to install your own modules.

- Load the python module

```bash
$ module load python3
```

- Create the virtualenv - in this case we are creating a virtual environment in the "my_python" directory within the home directory.

```bash
$ virtualenv --system-site-packages --prompt=$USER-my_python my_python
```

- Activate the virtual environment

```bash
$ source $HOME/my_python/bin/activate
```

On next login, you will only need to repeat the final step to load your environment and any libraries you have installed into it.

To install libraries, you can simply run a standard pip command, for example, to install the gi module:

```bash
$ pip install gi
```

### Conda instructions

If you need a version of Python, other than the ones that are pre-installed on our HPC system, then you can install it for your account, without admin privileges, with the help of Conda. Conda is an open-source package manager and environment management system, and it is probably the most popular package manager for Python and R. There are basically two ways to install Conda; either through Anaconda, which is a distribution of Python and R for scientific computing that includes many data-science packages, or through a stripped-down version called Miniconda, which includes only Conda, Python and a small number of required packages. Since the Anaconda installation is bloated and takes up a few GBs of disk space, and a typical user will only need a small fraction of the included packages, here we will describe the installation of the latter.

### Miniconda installation

You first need to dowload the install script from [this](https://docs.conda.io/en/latest/miniconda.html) webpage. Right-click and copy the link for the latest **Linux 64bit** Miniconda3 installer and then connect to DIaL3. Open a terminal and download the script with the `wget` command, e.g.

```bash
$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -P ~
```

which will download it at your home directory `~`. Now navigate to your home directory with `cd ~` and execute it with

```bash
$ bash Miniconda3-latest-Linux-x86_64.sh
```

Follow the instructions and press `Enter` to read the License Agreement, then `q` to go to the last page and finally type `yes` and press `Enter` if you accept the terms. You will then be asked for the directory where you want Miniconda to be installed. The default location is `~/miniconda3` and you will have to press `Enter` to confirm. The installer then prompts “*Do you wish the installer to initialize Miniconda3 by running conda init*“. Enter `yes`, then close and re-open the terminal for the changes to take effect. You will now see the word `(base)` just before your username, which means that the base environment is activated. You can now delete the downloaded shell script with `rm Miniconda3-latest-Linux-x86_64.sh`.

**Important**: Auto-activating the base environment may cause problems accessing HPC using NX (NoMachine). We recommend that you set the `auto_activate_base` parameter to false, by typing:

```bash
$ conda config --set auto_activate_base false
```

If you experience problems with NoMachine then follow the instructions [here](https://uniofleicester.sharepoint.com/sites/Research-Computing/SitePages/hpc-faq.aspx).

### Managing conda environments

To create a conda environment with a specific Python version type

```bash
$ conda create -n ENVNAME python=3.8
```

where **ENVNAME** is a name of your choice. This command will install the latest Python in the 3.8 branch. To verify that the environment was successfully installed type

```bash
$ conda env list
```

which lists all your environments. If you followed the guide till here, you should see two environments; the base and the one you created in the previous step. To activate it run

```bash
$ conda activate ENVNAME
```

To install a python package on that environment, e.g. `numpy` type:

```bash
$ conda install numpy
```

while the environment is activated, and if you want a specific version of that package you can use

```bash
$ conda install numpy=1.18.1
```

These commands with look for the package in the default channels. If you want to also specify a channel you can use the `-c` flag, e.g.

```bash
$ conda install -c conda-forge numpy
```

You can search for packages [here](https://anaconda.org/). If a package is unavailable through conda, but is available in the [Python Package Index](https://pypi.org/) (Pypi) repository, then you can install it with the `pip` command (e.g. `pip install pycuda`). It is suggested that you install packages with `pip` only after you’ve installed all the packages that you can with `conda`.

### Using conda in an HPC batch job

Now, if you want to use a conda environment in a non-interactive job, you have to activate it by adding the following code in your submit script, before executing your code (change the path to the location where you’ve installed miniconda):

```bash
$ source ~/miniconda3/bin/activate ENVNAME
```

Finally, to delete an environment first deactivate it with `conda deactivate` and then type:

```bash
$ conda remove -n ENVNAME --all
```

which will remove the environment and all installed packages.

