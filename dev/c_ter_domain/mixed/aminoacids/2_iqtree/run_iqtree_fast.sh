#!/bin/bash

#SBATCH -A mdm_db_computations
#SBATCH -p fast
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J iqfast_c-ter
#SBATCH -o log_iqfast.out
#SBATCH -e log_iqfast.err

iqtree -fast -s data/is110_round-1_nop5_round-3_80-80_rep_seq.maff-add.afa -st AA -m LG+G4 -nt $SLURM_CPUS_PER_TASK -pre results/iqfast/is110_round-1_nop5_round-3_80-80_rep_seq.maff-add.afa
