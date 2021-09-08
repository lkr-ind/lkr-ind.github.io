# Batch system

The DiaL3 system is shared across many users and to ensure fair use everyone must do their computations by submitting jobs through a batch system that will execute the applications on the available resources.

The batch system on DiAL3 is [SLURM](https://slurm.schedmd.com/) (Simple Linux Utility for Resource Management.)

## Creating a job script

To run a job on the system you need to create a job script. A job script is a regular shell script (bash) with some directives specifying the number of CPUs, memory, etc., that will be interpreted by the batch system upon submission.

You can find job script examples in [Job script examples](./job_types.md)

After you wrote your job script as shown in the examples, you can submit it to the scheduler by using the following command:

```bash
$ sbatch jobscript.sh
```

## How to pass command-line parameters to the job script

It is sometimes convenient if you do not have to edit the job script every time you want to change the input file. Or perhaps you want to submit hundreds of jobs and loop over a range of input files. For this it is handy to pass command-line parameters to the job script. 

In SLURM you can do this by:

```bash
$ sbatch myscript.sh myinput myoutput
```

And then you can pick the parameters up inside the job script:

```bash
#!/bin/bash

#SBATCH ...
#SBATCH ...
...

# argument 1 is myinput
# argument 2 is myoutput
mybinary.x < ${1} > ${2}
```

Please note that any command starting with `#SBATCH` is an instruction to the scheduler and not a comment.