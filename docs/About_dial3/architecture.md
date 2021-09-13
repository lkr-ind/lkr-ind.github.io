# DIaL3 Technical Specifications

The DIaL3 system has a total of 25,600 AMD EPYC compute cores (~57.6 Tera flops). The detailed specifications are as follows:-

- **Compute nodes:** The system comprise of 200 compute nodes each having 2 x AMD EPYC 7742 (Rome) processors. Each processor has 64 cores running at a base frequency of 2.25 GHz. 128 cores per nodes.<br/><br/>
- **Login nodes**: There are two login nodes comprising of 2 x AMD EPYC 7502 processors. Each processor has 32-Cores thereby leading to a total of 128 cores on login nodes. <br/><br/>
- **RAM on each compute node:** Each compute node consists of 512 GB of DDR4 RAM thereby providing 4 GB of RAM for each core. <br/><br/>
- **Interconnect:** EDR Infiniband 200Gb/s, 3:1 blocking <br/><br/>
- **Storage:** 4PB HPE/Cray ClusterStor <br/><br/>
- **Operating System:** Centos 8 <br/><br/>
- **Job Scheduler:** Slurm Workload manager<br/><br/>