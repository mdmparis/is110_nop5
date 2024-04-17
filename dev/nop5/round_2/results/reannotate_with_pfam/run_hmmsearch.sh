#! /bin/bash

#SBATCH -A mdm_db_coli
#SBATCH -J nop5_hits_pfam
#SBATCH -N 1 # number of nodes required
#SBATCH --ntasks=1
#SBATCH --mem 32Gb
#SBATCH --cpus-per-task=5
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

out_name="reannotate_nop58_pfam"

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${out_name}_pfam_hits.tsv --domtblout results/${out_name}_pfam_domtbl.tsv --pfamtblout results/${out_name}_pfam_pftblout.tsv data/PF09785_PF01798_PF02371.hmm data/nop5_round-2_hits_1e-5_len-300-700_kingdom=all.faa

