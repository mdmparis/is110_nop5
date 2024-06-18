#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH -J hmmsearch_pf04848
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

hmmsearch --cut_ga --cpu $SLURM_CPUS_PER_TASK --tblout results/pf04848_hits_kingdom=all.tsv --domtblout results/pf04848_domtbl_kingdom=all.tsv --pfamtblout results/pf04848_pftblout_kingdom=all.tsv data/PF04848.hmm /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/ALL_EUK_BACT-0722_ARCH.prot
