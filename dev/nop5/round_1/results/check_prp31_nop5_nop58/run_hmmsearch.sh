#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J check_nop5_prp31
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

file_name="nop5_nop58_prp31_specific_profile"
hmm_file="data/all_prp31_nop5_nop58_specific.hmm"

hmmsearch --cut_ga --cpu $SLURM_CPUS_PER_TASK --tblout results/${file_name}_hits.tsv --domtblout results/${file_name}_domtbl.tsv --pfamtblout results/${file_name}_pftblout.tsv ${hmm_file} data/nop5_round-1_hits_1e-5_len-300-700_kingdom=euk-arch.faa

