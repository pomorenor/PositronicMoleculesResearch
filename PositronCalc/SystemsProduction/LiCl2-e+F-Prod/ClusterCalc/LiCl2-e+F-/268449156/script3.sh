#!/bin/bash -l
/opt/lowdin2/bin/lowdin -n $SLURM_CPUS_PER_TASK -i p3.lowdin > p3.log 2>&1
