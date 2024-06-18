#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH -J muscle_cter
#SBATCH -o log_muscle.out
#SBATCH -e log_muscle.err

muscle -super5 data/is110_round-1_nop5_round-3_80-80_rep_seq.faa -output results/is110_nop5_c-ter_algo=muscle.@.afa -amino -threads $SLURM_CPUS_PER_TASK -perm all -perturb 0 -refineiters 200 -consiters 3
