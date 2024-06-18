#!/bin/bash

#SBATCH -A mdm_db_computations
#SBATCH -p long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J iqtree_is110_nop5_c-ter
#SBATCH -o log_iqtree.out
#SBATCH -e log_iqtree.err

iqtree -s data/is110_round-1_nop5_round-3_80-80_rep_seq.maff-add.afa -st AA -B 1000 -m LG+G4 -nt $SLURM_CPUS_PER_TASK -pre results/iqtree/is110_round-1_nop5_round-3_80-80_rep_seq.maff-add.afa
