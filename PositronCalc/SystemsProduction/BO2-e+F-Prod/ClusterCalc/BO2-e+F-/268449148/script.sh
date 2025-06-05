#!/bin/bash -l
/opt/lowdin2/bin/lowdin -n $SLURM_CPUS_PER_TASK -i p2.lowdin > p2.log 2>&1
