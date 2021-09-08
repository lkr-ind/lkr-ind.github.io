# SLURM Workload Manager

DiaL3 use [SLURM](https://slurm.schedmd.com/documentation.html) as its workload manager i.e. SLURM is responsible for scheduling and running jobs on the compute nodes as and when they are available.

Some of the useful SLURM commands are:-

`salloc` :- is used to allocate resources for a job in real time. Typically this is used to allocate resources and spawn a shell. The shell is then used to execute `srun` commands to launch parallel tasks.

`sbatch` :-  is used to submit a job script for later execution. The script will typically contain one or more `srun` commands to launch parallel tasks.

`scancel` :- is used to cancel a pending or running job or job step. It can also be used to send an arbitrary signal to all processes associated with a running job or job step.

`scontrol` :- is the administrative tool used to view and/or modify SLURM state. Note that many of the `scontrol` commands can only be executed as user root.

`sinfo` :- reports the state of partitions and nodes managed by SLURM. It has a wide variety of filtering, sorting, and formatting options.

`squeue` :- reports the state of jobs or job steps. It has a wide variety of filtering, sorting, and formatting options. By default, it reports the running jobs in priority order and then the pending jobs in priority order.

`srun` :- is used to submit a job for execution or initiate job steps in real time. `srun` command has a wide variety of options to specify resource requirements, including: minimum and maximum node count, processor count, specific nodes to use or not use, and specific node characteristics (so much memory, disk space, certain required features, etc.). A job can contain multiple job steps executing sequentially or in parallel on independent or shared resources within the job's node allocation.

## sbatch

As mnetioned above, `sbatch` submits a batch script to SLURM. The batch script may be given to sbatch through a file name on the command line, or if no file name is specified, `sbatch` will read in a script from standard input. The batch script may contain options preceded with `#SBATCH` before any executable commands in the script. `sbatch` will stop processing further `#SBATCH` directives once the first non-comment non-whitespace line has been reached in the script. `sbatch` exits immediately after the script is successfully transferred to the SLURM controller and assigned a SLURM job ID.

**Example:**

```bash
#!/bin/bash
#
#! Example SLURM job script for DiRAC 3

#SBATCH --export=NONE
#SBATCH --job-name=test_slurm
#SBATCH --nodes=2
##SBATCH --ntasks=8
#SBATCH --ntasks-per-node=3
#SBATCH --mem=10G
#SBATCH --time=00:05:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=tk253@le.ac.uk
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

echo $SLURM_NTASKS
echo $SLURM_NTASKS_PER_NODE
echo $SLURM_JOB_NODELIST
```

For submitting the above script to the job scheduler, use the following command.

```bash
$ sbatch your_job_script.sh
```

On DIaL3, the above script will lead to the following output:

```
6
3
dnode[001-002]
```

*Hint:* To convert the `$SLURM_JOB_NODELIST` to a list of individual host names use `scontrol show hostnames $SLURM_JOB_NODELIST`. For example

```bash
$ scontrol show hostnames dnode[001-003,005]
```

returns:

```
dnode001
dnode002
dnode003
dnode005
```

### Sbatch Options

**--export**= < [ALL,] environment variables| ALL | NONE >

> Identify which environment variables from the submission environment are propagated to the launched application. Note that `SLURM_*` variables are always propagated.
>
> **--export=ALL** :- Default mode if --export is not specified. All of the users environment will be loaded
>
> **--export=NONE** :- Only `SLURM_*` variables from the user environment will be defined. User must use absolute path to the binary to be executed that will define the environment. User can not specify explicit environment variables with NONE.

**-N, --nodes**= < minnodes[-maxnodes] >

> Request that a minimum of *minnodes* nodes be allocated to this job. A maximum node count may also be specified with *maxnodes*. If only one number is specified, this is used as both the minimum and maximum node count.

**-n, --ntasks**= < number >

> `sbatch` does not launch tasks, it requests an allocation of resources and submits a batch script. This option advises the SLURM controller that job steps run within the allocation will launch a maximum of number tasks and to provide for sufficient resources. The default is one task per node, but note that the *--cpus-per-task* option will change this default.

**--ntasks-per-node**= < ntasks >

> Request that *ntasks* be invoked on each node. If used with the *--ntasks* option, the *--ntasks* option will take precedence and the *--ntasks-per-node* will be treated as a maximum count of tasks per node. Meant to be used with the --nodes option. This is related to *--cpus-per-task=ncpus*, but does not require knowledge of the actual number of cpus on each node.

**--mem**= < size[units] >

> Specify the real memory required per node. Default units are megabytes. Different units can be specified using the suffix [K|M|G|T]. Default value is DefMemPerNode and the maximum value is MaxMemPerNode.

**%x**

> Job name

**%j**

> Job id of the running job.

## squeue

It is used to view job and job step information for jobs managed by Slurm.

### Squeue Options

**-a, --all**

> Display information about jobs and job steps in all partitions. This causes information to be displayed about partitions that are configured as hidden, partitions that are unavailable to a user's group, and federated jobs that are in a "revoked" state.

**-i <seconds>, --iterate=<seconds>**

> Repeatedly gather and report the requested information at the interval specified (in seconds). By default, prints a time stamp with the header.

**-u <user_list>, --user=<user_list>**

> Request jobs or job steps from a comma separated list of users. The list can consist of user names or user id numbers. Performance of the command can be measurably improved for systems with large numbers of jobs when a single user is specified.

For example, we can use the squeue command as follows:

```bash
$ squeue -a -u your_username -i 30
```

## Summary

| Task                         | Slurm                      |
| ---------------------------- | -------------------------- |
| Submit a job                 | `sbatch my_job_script.sh`  |
| Delete a job                 | `scancel job_id`           |
| Show job status              | `squeue`                   |
| Show expected job start time | `squeue --start`           |
| Show queue info              | `sinfo`                    |
| Show queue details           | `scontrol show partition`  |
| Show job details             | `scontrol show job job_id` |

