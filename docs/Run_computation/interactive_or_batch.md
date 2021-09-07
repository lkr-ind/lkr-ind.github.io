# Interactive or batch

You can run computations interactively or in batch.

## Interactive processing

Interactive processing is the simplest way to work on a system. You log in, run  commands which execute immediately, and log off when you've finished.  You can use either the command line or a graphical environment.

Interactive jobs run directly on the limited number of login nodes (servers) on  each cluster. **DiAL3** has two login nodes. Although  user login sessions are spread across these nodes, interactive processes will be competing with each other.

### When should you use interactive processing?

- Short tasks
- Tasks that require frequent user interaction
- Graphically intensive tasks

The design of **DIaL3** is strongly biased towards batch jobs. It has 200  compute nodes and only two login nodes. Therefore interactive processes  on ALICE shouldn't take more than a few minutes of CPU time.

There are hard limits applied which means  that a process will be killed if it uses more than a few -----  hours of CPU time on the login nodes. Furthermore, should the  administrators be alerted to heavy processing on the login nodes,  those processes are likely to be killed with no warning in order to  ensure the login nodes remain responsive for everyone.

### What if you need to run longer processes interactively?

You can submit jobs to the scheduler for interactive running. These jobs  provide a login to one of the compute nodes with the requested resources dedicated to you. These jobs support X-forwarding so graphical  applications will work as normal. For more information, see [Interactive jobs](https://uniofleicester.sharepoint.com/sites/Research-Computing/SitePages/job-types-hpc.aspx#interactive-jobs).

## Batch processing

### What is batch processing?

Batch processing is more complex because work has to carefully planned and  able to run without user interaction. Batch jobs are submitted to a [job scheduler](https://uniofleicester.sharepoint.com/sites/Research-Computing/SitePages/scheduler-hpc.aspx) and run on the first available compute node(s). Once submitted, you can log off and wait for the jobs to complete, with the option to be sent an  email when this has happened. Although batch jobs may have to wait in a  queue before running, they are then given a dedicated set of resources  to ensure that they complete as quickly as possible.

### When should you use batch processing?

- Longer running processes
- Parallel processes
- Running large numbers of short jobs simultaneously
- Tasks that can be left running for a significant amount of time without any interaction

