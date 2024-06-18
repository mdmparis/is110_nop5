#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH -p long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J iqtree_clipkit
#SBATCH -o log_iqtree_clipkit.out
#SBATCH -e log_iqtree_clipkit.err

iqtree --undo --nmax 3000 -s data/is110_round-1_nop5_round-3_80-80_rep_seq.maff-add.afa_kpi-gappy=0.98.afa -st AA -B 1000 -m LG+G4 -nt $SLURM_CPUS_PER_TASK -pre results/iqtree_clipkit/is110_round-1_nop5_round-3_80-80_rep_seq.maff-add.afa_kpi-gappy=0.98.afa
