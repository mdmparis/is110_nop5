#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH -p long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=50
#SBATCH -J iqt_concat-with-ruvc_like_clipkit
#SBATCH -o log_iqtree_clipkit_with_ruvc_like.out
#SBATCH -e log_iqtree_clipkit_with_ruvc_like.err

iqtree --undo --nmax 4000 -s data/cat_n-ter_coiled-coil_c-ter_with-ruvc-like.afa.gappy=0.99.clipkit -st AA -B 1000 -m Q.pfam+G4 -nt $SLURM_CPUS_PER_TASK -pre results/iqtree_with_ruvc_like_clipkit/cat_n-ter_coiled-coil_c-ter_with-ruvc-like.afa.gappy=0.99.clipkit
