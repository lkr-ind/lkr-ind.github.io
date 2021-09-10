# File Systems on DIaL3

There are a number of file systems on DIaL3 that should be used in different ways:

- [/home](#home)
- [/scratch](#scratch)
- [/tmp](#tmp)

### /home

Every user has a home directory within the `/home` file system. This  will be your current working directory when you login to DIaL3. 

The home directory should only be used to store program code, job  submission scripts, configuration files and small amounts of data.

Your home directory can be referenced on the Linux command line with the shorthand `~`. The simple command `cd` with no arguments will return you to your home directory.

Users' home directories are backed up nightly.



### /scratch

You will have a scratch directory on the scratch file system for each project that you are associated with.

The location will be `/scratch/project/username` - so users in multiple projects will have several to choose from. As each user's scratch directory is readable by other members of the same  project, it's important to choose the correct one depending on which  project is being worked on.

The directory `/scratch/project/shared` has special permissions to ensure that all files within are always owned by the project group.

The scratch directory used should be the main location for job files, and generally should be used as the working directory for jobs. The  scratch space has quotas applied which are in line with those requested  for “work” in DiRAC time applications. These are not allocations, only  quotas, so can add up to more than the available storage.

<span style="color:red">**Warning:**</span> Files within `/scratch` are **not backed up**. Furthermore, there is an automated process which deletes any files that haven't been accessed in more than **60 days**. There will be no prior warning that files will be deleted, it is up to  users to ensure that important data is not kept in /scratch for long  term storage.



### /tmp

Each compute node has a small amount of local disc mounted on `/tmp`.  For some jobs there may be a performance gain over /tmp in using this  file system for intermediate files.

Standard compute nodes have 100GB available. The preferred way to use `/tmp` within a job is to refer to it using the environment variable **TMPDIR**. This way the job's files are cleaned-up when the job finishes  automatically. Otherwise it is your job's responsibility to remove files from the local file system when it ends.

<span style="color:red">**Warning:**</span> The `/tmp` file system is not backed up, and the contents are deleted whenever the compute node reboots for any reason.

Files on `/tmp` should only be considered safe for the duration of the job which they belong to.

