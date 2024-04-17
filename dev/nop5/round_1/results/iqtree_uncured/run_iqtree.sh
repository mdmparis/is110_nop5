#! /bin/bash

#SBATCH -A mdm_db_computations
#SBATCH -J iqt_nop5_round-1_uncured
#SBATCH -p long
#SBATCH -N 1 # number of nodes required
#SBATCH --ntasks=1
#SBATCH --mem 80Gb
#SBATCH --cpus-per-task=20
#SBATCH -o log_iqtree.out
#SBATCH -e log_iqtree.err

# mdm_db_coli/conda/iqtree environment already activated

# -m MFP -> Model Finder Plus : automatically find the right substitution model
# --undo : pursue tree search for a few hundred more rounds
iqtree -s data/nop5_round-1_80-80_kingdom=euk-arch_rep_seq_mafft-add.afa_clipkit=0.98.clipkit -st AA -m LG+G4 -B 1000 -nt 20 --nmax 2000
