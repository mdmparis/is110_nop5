#!/bin/bash

#SBATCH -A mdm_db_computations
#SBATCH -p long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J iqtree_nop5_prp31
#SBATCH -o log_iqtree.out
#SBATCH -e log_iqtree.err

iqtree --nmax 5000 -s data/nop5_prp31_nop-dom.afa -st AA -B 1000 -m LG+G4 -nt $SLURM_CPUS_PER_TASK -pre results/nop5_prp31_nop-dom.afa
