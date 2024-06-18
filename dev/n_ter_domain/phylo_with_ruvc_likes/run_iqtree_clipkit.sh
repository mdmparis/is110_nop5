#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH -p long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH -J iqtree_n-ter_phylo_clipkit
#SBATCH -o log_iqtree.out
#SBATCH -e log_iqtree.err

iqtree --undo --nmax 2500 -s data/all_n-ter.afa.gapp=0.99.clipkit -st AA -B 1000 -m Q.pfam+G4 -nt $SLURM_CPUS_PER_TASK -pre results/all_n-ter.afa.gapp=0.99.clipkit
