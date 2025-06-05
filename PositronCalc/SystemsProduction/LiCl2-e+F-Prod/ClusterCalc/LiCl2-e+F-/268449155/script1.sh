#!/bin/bash -l
/opt/lowdin2/bin/lowdin -n $SLURM_CPUS_PER_TASK -i p1.lowdin > p1.log 2>&1
