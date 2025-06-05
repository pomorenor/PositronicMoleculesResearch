#!/bin/bash -l

#SBATCH --job-name=FOBO1
#SBATCH --clusters=cecc
#SBATCH --partition=cpu.cecc
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --output=/homes/qteorica/rafael/BO2-e+F-/N.lowdin_%j.out
#SBATCH --error=/homes/qteorica/rafael/BO2-e+F-/N.lowdin_%j.err
#SBATCH --mail-user=areyesv@unal.edu.co
#SBATCH --export=ALL
#SBATCH --export=SCRATCH_DIR=/scratch/$SLURM_JOB_ACCOUNT/$SLURM_JOB_USER/$SLURM_JOB_ID

	unset SINGULARITY_BINDPATH
	export SINGULARITY_BINDPATH="/scratch:/scratch"
	cd $SCRATCH_DIR
	singularity run /localapps/lowdinXQMeCha.sif  ./script1.sh
