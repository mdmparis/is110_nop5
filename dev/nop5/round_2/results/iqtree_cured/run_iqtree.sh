#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH -J iq_bca_nop5_round-2
#SBATCH -o log_iqtree.out
#SBATCH -e log_iqtree.err

permut="none"
iqtree -s data/nop5_round-2_60-60_algo=muscle.${permut}.0.afa_gappy=0.98.clipkit -st AA -m LG+G4 -B 1000 -nt $SLURM_CPUS_PER_TASK
