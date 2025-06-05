#!/bin/bash -l

#SBATCH --job-name=LiClCl
#SBATCH --clusters=cecc
#SBATCH --partition=cpu.cecc
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --output=/homes/qteorica/pomorenor/LiClCl1/NAME.lowdin_%j.out
#SBATCH --error=/homes/qteorica/pomorenor/LiClCl1/NAME.lowdin_%j.err
#SBATCH --mail-user=pomorenor@unal.edu.co
#SBATCH --export=ALL
#SBATCH --export=SCRATCH_DIR=/scratch/$SLURM_JOB_ACCOUNT/$SLURM_JOB_USER/$SLURM_JOB_ID

	unset SINGULARITY_BINDPATH
	export SINGULARITY_BINDPATH="/scratch:/scratch"
	cd $SCRATCH_DIR
	singularity run /localapps/lowdinXQMeCha.sif ./homes/qteorica/pomorenor/LiClCl1/script.sh
