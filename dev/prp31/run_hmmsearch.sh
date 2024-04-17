#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J prp31_round-1
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

file_name="prp31_round-1"
hmm_profile="PRPF31_orthologs_cured.hmm"
min_len=200
max_len=1000

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${file_name}_hits_kingdom=euk-bact.tsv --domtblout results/${file_name}_domtbl_kingdom=euk-bact.tsv --pfamtblout results/${file_name}_pftblout_kingdom=euk-bact.tsv data/${hmm_profile} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/ALL_EUK_BACT-0722.prot

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${file_name}_hits_kingdom=archaea.tsv --domtblout results/${file_name}_domtbl_kingdom=archaea.tsv --pfamtblout results/${file_name}_pftblout_kingdom=archaea.tsv data/${hmm_profile} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/GTDBarchaea2339.faa

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${file_name}_hits_kingdom=asgard.tsv --domtblout results/${file_name}_domtbl_kingdom=asgard.tsv --pfamtblout results/${file_name}_pftblout_kingdom=asgard.tsv data/${hmm_profile} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/Asgard297_20211009.faa

cat results/*_hits* | grep -v "#" | awk '$5 < 1e-5' >  results/${file_name}_hits_1e-5_kingdom=all.tsv
cat results/${file_name}_hits_1e-5_kingdom=all.tsv | awk '{print $1}' > results/${file_name}_hits_1e-5_kingdom=all.ids
n_bact=$(cat results/${file_name}_hits_kingdom=euk-bact.tsv | grep -v "#" | grep -v -E "GCA|GCF" | awk '$5 < 1e-5' | wc -l)
n_euk=$(cat results/${file_name}_hits_kingdom=euk-bact.tsv | grep -v "#" | grep -E "GCA|GCF" | awk '$5 < 1e-5' | wc -l)
n_arch=$(cat results/${file_name}_hits_kingdom=archaea.tsv | grep -v "#" | awk '$5 < 1e-5' | wc -l)
n_asg=$(cat results/${file_name}_hits_kingdom=asgard.tsv | grep -v "#" | awk '$5 < 1e-5' | wc -l)
n=$(cat results/${file_name}_hits_1e-5_kingdom=all.ids | wc -l)
echo "Found $n hits with e-value < 1e-5." >> results/${file_name}_hits_kingdom=all.report
echo "- $n_bact in Bacteria." >> results/${file_name}_hits_kingdom=all.report
echo "- $n_euk in Eukaryotes." >> results/${file_name}_hits_kingdom=all.report
echo "- $n_arch in Archaea." >> results/${file_name}_hits_kingdom=all.report
echo "- $n_asg in Asgard." >> results/${file_name}_hits_kingdom=all.report

cat results/${file_name}_hits_1e-5_kingdom=all.tsv | awk '{print $5}' | awk -F'e' '{if (NF > 1) {print $2}}' | hist -x -b 100 > results/${file_name}_hits_1e-5_kingdom=all_e-value.hist
getprot-para2 -c $SLURM_CPUS_PER_TASK results/${file_name}_hits_1e-5_kingdom=all.ids
mv ${file_name}_hits_1e-5_kingdom=all.ids.faa results/${file_name}_hits_1e-5_kingdom=all.faa 
n_seqs=$(seqkit stat results/${file_name}_hits_1e-5_kingdom=all.faa)
echo "$n_seqs sequences found in the database." >> results/${file_name}_hits_kingdom=all.report
seqkit fx2tab --length --name results/${file_name}_hits_1e-5_kingdom=all.faa | awk '{print $1"\t"$NF}' > results/${file_name}_hits_1e-5_kingdom=all_len.tsv
cat results/${file_name}_hits_1e-5_kingdom=all_len.tsv | awk '{print $2}' | hist -x -b 100 > results/${file_name}_hits_1e-5_kingdom=all_len.hist 
seqkit seq -m ${min_len} -M ${max_len} results/${file_name}_hits_1e-5_kingdom=all.faa > results/${file_name}_hits_1e-5_len-${min_len}-${max_len}_kingdom=all.faa
n_seqs_len=$(seqkit stat results/${file_name}_hits_1e-5_len-${min_len}-${max_len}_kingdom=all.faa)
echo "$n_seqs_len sequences with ${min_len} < length < ${max_len}." >> results/${file_name}_hits_kingdom=all.report

echo "Done!" >> results/${file_name}_hits_kingdom=all.report
