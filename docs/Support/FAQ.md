# Issues with software / applications

### How do I set up my account so the modules I always need are loaded automatically?

You can edit the file

```
~/.bashrc
```

adding entries at the end of this file to always load the modules you need. If you haven't made any other modifications to this file and you always  wish to use gcc version 9.3.0, your .bashrc file would become:

```bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions
module load gcc/9.3.0
```

### I get a message saying "command not found".

This is probably because you haven't loaded the module which sets up your environment correctly for this software. See the [Modules](../Software/module_system.md) page for more information.

## Job submission issues

### My process was killed.

The login nodes on DiaL3 have a hard limit of --- hours of *CPU time* per process. If this is exceeded, the process will be killed. 

This limit applies to *CPU time* not *runtime:* an idle process may run for many hours without consuming much *CPU time.* Similarly a multicore process may consume two hours of *CPU time* very quickly.

Long running processes should not be launched directly on the login nodes.  Instead they should be submit to the queue using the job scheduler. For  further information see the page about [Interactive vs Batch jobs](../Run_computation/interactive_or_batch.md) and [Job types](../Run_computation/job_types.md).

### My job was killed but there is no output and no errors were reported.

Almost certainly this is because you have not specified a value for **vmem**, or have a value which is too low. Increase the value requested and resubmit your job.

### My job started but only ran for a minute.

It's likely that you've not requested the **walltime** for a job. This is required to ensure that jobs can be scheduled  effectively and that the system can be emptied for service days. If it's not specified, the default value is one minute. There is more  information in the page about [Submitting Jobs](../Run_computation/job_types.md)

### My job shows as Blocked or Deferred?

Jobs can be placed in the Deferred state for several reasons:

- You have too much outstanding work (i.e. a large number of running and/or idle jobs)
- A back-end service was experiencing problems when you submitted your job
- There is something wrong in your job submission script

In the first two cases you don't need to do anything as the scheduler will re-assess Deferred jobs after an hour to see if the condition that led  to them being deferred has gone away. If so, your jobs will be moved to the running or idle state as normal. The command

```bash
 $ checkjob -v <jobid>
```

will give you more information about why a job has been deferred.

### How do I acknowledge use of the HPC facilities in research publications?

You can use the following statements to acknowledge the use of DIaL3 as mentioned on [Acknowlede DiRAC](https://dirac.ac.uk/community/#Acknowledge)

*This work was performed using the DiRAC Data Intensive service at Leicester, operated by the University of Leicester IT Services, which forms part of the STFC DiRAC HPC Facility ([www.dirac.ac.uk](http://www.dirac.ac.uk/)). The equipment was funded by BEIS capital funding via STFC capital grants ST/K000373/1 and ST/R002363/1 and STFC DiRAC Operations grant ST/R001014/1. DiRAC is part of the National e-Infrastructure.*

