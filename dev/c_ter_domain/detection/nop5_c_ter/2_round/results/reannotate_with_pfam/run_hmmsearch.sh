#! /bin/bash

#SBATCH -A prokeuk_immunity
#SBATCH -J nop58_c-ter_pfam
#SBATCH -N 1 # number of nodes required
#SBATCH --ntasks=1
#SBATCH --mem 32Gb
#SBATCH --cpus-per-task=10
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

in_file="data/nop5-c-ter_round-2_hit-region_1e-5_len-200-1000_qcov-gt-0.80_kingdom=all.faa"
profile_hmm="data/PF09785_PF01798_PF02371.hmm"
out_name="hits_vs_pfam"

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${out_name}_pfam_hits.tsv --domtblout results/${out_name}_pfam_domtbl.tsv --pfamtblout results/${out_name}_pfam_pftblout.tsv ${profile_hmm} ${in_file}

