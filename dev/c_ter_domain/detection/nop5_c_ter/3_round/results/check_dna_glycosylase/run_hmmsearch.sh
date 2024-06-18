#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH -J dna_glyco_pfam_vs_nop5_hits
#SBATCH -o log_hmmsearch_dna_glyco.out
#SBATCH -e log_hmmsearch_dna_glyco.err

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/dna_glycosylase_pfam_full_prot_hits_kingdom=euk-bact.tsv --domtblout results/dna_glycosylase_pfam_full_prot_domtbl_kingdom=euk-bact.tsv --pfamtblout results/dna_glycosylase_pfam_full_prot_pftblout_kingdom=euk-bact.tsv data/PF00633_PF00730.hmm data/nop5-c-ter_round-3_hits_1e-5_len-200-1000_kingdom=all.faa
