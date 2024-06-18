#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH -p long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH -J iqtree_c_ter_muscle
#SBATCH -o log_iqtree_2.out
#SBATCH -e log_iqtree_2.err

iqtree --nmax 3000 -s data/is110_nop5_c-ter_algo=muscle.none.0.afa.kpi-gappy=0.98.clipkit -st AA -B 1000 -m LG+G4 -nt AUTO -pre results/iqtree_clipkit/is110_nop5_c-ter_algo=muscle.none.0.afa.kpi-gappy=0.98.clipkit
