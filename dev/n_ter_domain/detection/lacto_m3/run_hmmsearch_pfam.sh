#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH -J hmmsearch_pf07066
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

hmmsearch --cut_ga --cpu $SLURM_CPUS_PER_TASK --tblout results/pf07066_hits_kingdom=all.tsv --domtblout results/pf07066_domtbl_kingdom=all.tsv --pfamtblout results/pf07066_pftblout_kingdom=all.tsv data/PF07066.hmm /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/ALL_EUK_BACT-0722_ARCH.prot
