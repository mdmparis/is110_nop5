#!/bin/bash

#SBATCH --qos normal
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=50
#SBATCH -J is110_round-1
#SBATCH -o log_blastp.out
#SBATCH -e log_blastp.err

source /pasteur/appa/homes/hvaysset/miniforge3/etc/profile.d/conda.sh
conda activate /pasteur/zeus/projets/p01/MDM/MDM_conda/mdm_base_env/

blastp -num_threads $SLURM_CPUS_PER_TASK -query data/A0A809T667.faa -db /pasteur/zeus/projets/p01/MDM/GENOME_DATABASE/Bacteria/gembase/Microbial_0722/Genomes/ALL_Proteins_0722.blast_db/ALL_Proteins_0722.blast_db -out results/blast_A0A809T667_eval-1e-80.res -outfmt 7 -evalue 1e-80 -max_target_seqs 1000000
