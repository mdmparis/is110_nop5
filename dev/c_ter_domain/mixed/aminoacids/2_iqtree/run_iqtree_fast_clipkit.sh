#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH -p fast
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J iqfast_c-ter_clip
#SBATCH -o log_iqfast_clip.out
#SBATCH -e log_iqfast_clip.err

iqtree -fast -s data/is110_round-1_nop5_round-3_80-80_rep_seq.maff-add.afa_kpi-gappy=0.98.afa -st AA -m LG+G4 -nt $SLURM_CPUS_PER_TASK -pre results/iqfast_clipkit/is110_round-1_nop5_round-3_80-80_rep_seq.maff-add.afa_kpi-gappy=0.98.afa
