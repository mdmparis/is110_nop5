#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH -J hmmsearch_yqgf_clan
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

hmmsearch --cut_ga --cpu $SLURM_CPUS_PER_TASK --tblout results/yqgf_clan_hits_kingdom=all.tsv --domtblout results/yqgf_clan_domtbl_kingdom=all.tsv --pfamtblout results/yqgf_clan_pftblout_kingdom=all.tsv data/yqgf_clan.hmm /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/ALL_EUK_BACT-0722_ARCH.prot
