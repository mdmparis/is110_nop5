#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH -J nop5_round-2
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/nop5_round-2_hits_kingdom=euk.tsv --domtblout results/nop5_round-2_domtbl_kingdom=euk.tsv --pfamtblout results/nop5_round-2_pftblout_kingdom=euk.tsv data/nop5_round-1_90-90_rep_seq_kingdom=euk-arch_cured.mafft-add.hmm /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/ALL_EUK_BACT-0722.prot

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/nop5_round-2_hits_kingdom=archaea.tsv --domtblout results/nop5_round-2_domtbl_kingdom=archaea.tsv --pfamtblout results/nop5_round-2_pftblout_kingdom=archaea.tsv data/nop5_round-1_90-90_rep_seq_kingdom=euk-arch_cured.mafft-add.hmm /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/GTDBarchaea2339.faa

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/nop5_round-2_hits_kingdom=asgard.tsv --domtblout results/nop5_round-2_domtbl_kingdom=asgard.tsv --pfamtblout results/nop5_round-2_pftblout_kingdom=asgard.tsv data/nop5_round-1_90-90_rep_seq_kingdom=euk-arch_cured.mafft-add.hmm /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/Asgardv2.prt
