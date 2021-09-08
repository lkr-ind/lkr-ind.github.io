# Monitor your jobs

To see which of your jobs are running or to see which ones are still in queue, you can use the `squeue` command as follows:

```bash
$ squeue -u $USER
```

You will see an output similar to the following

```
JOBID  PARTITION        NAME     USER         ST   TIME      NODES  NODELIST(REASON)
123    parition_name    my_job   my_username  R    00:00:15  1 node dnode001
```

The various fields in the above output are explained below.

- **JOBID**: Job ID assigned to your job the scheduler.
- **PARTITION**: the partition you have chosen to run your job.
- **NAME**: You job name.
- **USER**: Your username.
- **ST**: This indicates the status of the job. Some of the possible status values are: R= Running, PD = Pending and CG = Completing.
- **TIME**: Time for which the job is running in HH:MM:SS.
- **NODES**: The number of nodes you have asked for or the number of nodes that have been allocated (depending on the state of your job).
- **NODELIST (REASON**): The nodes on which your job is running. If there is a problem with your job, it will also indicate a short message indicating the issue.

To delete your job or to remove it from the queue, you can use the `scancel` command as shown below.

```bash
$ scancel job_id
```

 