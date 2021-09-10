# Interactive jobs

## Starting an interactive job

You can run an interactive job like this:

```bash
$ srun  --account=YOUR_ACCOUNT_NAME --nodes=NUMBER_OF_NODES_REQUIRED --ntasks-per-node=NUMBER_TASKS_PER_NODE --time=HH:MM:SS --pty bash -i
```

An example of using the above command might look like the following on DIaL3:

```bash
$ srun --nodes=2 --ntasks-per-node=8 --time=01:00:00 --pty bash -i
```

Here we ask for a 8 cores on 2 nodes for one hour with the default amount of memory. The command prompt will appear as soon as the job starts.

This is how it looks once the interactive job starts:

```
srun: job 12345 queued and waiting for resources
srun: job 12345 has been allocated resources
```

Exit the bash shell to end the job. If you exceed the time or memory limits the job will also abort.

Interactive jobs have the same policies as normal batch jobs and there are no extra restrictions. Please be advised that you might be sharing the node with other users depending on the amount of resources you have asked for.

