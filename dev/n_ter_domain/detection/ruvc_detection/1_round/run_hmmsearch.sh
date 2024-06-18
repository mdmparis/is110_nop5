#! /bin/bash

#SBATCH -A mdm_db_computations
#SBATCH -J run_hmmsearch
#SBATCH -N 1 # number of nodes required
#SBATCH --ntasks=1
#SBATCH --mem 32Gb
#SBATCH --cpus-per-task=30
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

out_name="ruvc"
profile_HMM="data/interpro_PF02075_hits_reviewed_14-247.hmm"

# coli_base environment already activated
hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${out_name}_pfam_hits.tsv --domtblout results/${out_name}_pfam_domtbl.tsv --pfamtblout results/${out_name}_pfam_pftblout.tsv ${profile_HMM} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/ALL_EUK_BACT-0722.prot

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${out_name}_pfam_hits_kingdom=asgard.tsv --domtblout results/${out_name}_pfam_domtbl_kingdom=asgard.tsv --pfamtblout results/${out_name}_pfam_pftblout_kingdom=asgard.tsv ${profile_HMM} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/Asgardv2.prt

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${out_name}_pfam_hits_kingdom=archaea.tsv --domtblout results/${out_name}_pfam_domtbl_kingdom=archaea.tsv --pfamtblout results/${out_name}_pfam_pftblout_kingdom=archaea.tsv ${profile_HMM} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/GTDBarchaea2339.faa
