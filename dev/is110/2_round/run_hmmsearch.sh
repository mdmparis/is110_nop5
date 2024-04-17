#!/bin/bash

#SBATCH --qos fast
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J is110_round-2
#SBATCH -o log_hmmsearch_asgard.out
#SBATCH -e log_hmmsearch_asgard.err


# hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/is110_round-2_hits_kingdom=bacteria.tsv --domtblout results/is110_round-2_domtbl_kingdom=bacteria.tsv --pfamtblout results/is110_round-2_pftblout_kingdom=bacteria.tsv data/blast_A0A809T667_eval-1e-80_70-499.hmm /pasteur/zeus/projets/p01/MDM/GENOME_DATABASE/Bacteria/gembase/Microbial_0722/Genomes/ALL_Proteins_0722/ALL_Proteins_0722.prot

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/is110_round-2_hits_kingdom=archaea.tsv --domtblout results/is110_round-2_domtbl_kingdom=archaea.tsv --pfamtblout results/is110_round-2_pftblout_kingdom=archaea.tsv data/blast_A0A809T667_eval-1e-80_70-499.hmm /pasteur/zeus/projets/p01/MDM/GENOME_DATABASE/Archaea/GTDBarchaea2339.faa

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/is110_round-2_hits_kingdom=asgard.tsv --domtblout results/is110_round-2_domtbl_kingdom=asgard.tsv --pfamtblout results/is110_round-2_pftblout_kingdom=asgard.tsv data/blast_A0A809T667_eval-1e-80_70-499.hmm /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/Asgardv2.prt
