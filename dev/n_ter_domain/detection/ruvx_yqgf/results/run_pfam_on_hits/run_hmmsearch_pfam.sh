#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH -J hmmsearch_pfam_yqgf_clan_pfam
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

hmmsearch --cut_ga --cpu $SLURM_CPUS_PER_TASK --tblout results/yqgf_clan_pfam_hits_kingdom=all.tsv --domtblout results/yqgf_clan_pfam_domtbl_kingdom=all.tsv --pfamtblout results/yqgf_clan_pfam_pftblout_kingdom=all.tsv data/Pfam-A.hmm data/yqgf_clan_hits_1e-5_len-80-1000_kingdom=all.faa
