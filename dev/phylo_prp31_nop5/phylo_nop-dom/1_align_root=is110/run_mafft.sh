#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH -J prp31_nop5_root=is110
#SBATCH -o log_mafft.out
#SBATCH -e log_mafft.err

mafft --localpair --reorder --thread $SLURM_CPUS_PER_TASK data/nop5_prp31_is110_nop-dom.faa > results/nop5_prp31_is110_algo=mafft-local.afa
