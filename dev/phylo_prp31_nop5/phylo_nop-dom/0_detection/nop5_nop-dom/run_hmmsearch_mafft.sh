#!/bin/bash

#SBATCH -A mdm_db_coli
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH -J nop5_nop-dom
#SBATCH -o log_hmmsearch.out
#SBATCH -e log_hmmsearch.err

file_name="nop5_nop-dom"
hmm_profile="data/nop5_round-2_hits_1e-5_len-300-700_kingdom=archaea_1019-1545.hmm"
min_len=300
max_len=700
min_q_cov="0.80"  # min query (profile HMM) coverage)

mkdir results/raw results/reports

#hmmsearch --cut_ga --cpu $SLURM_CPUS_PER_TASK --tblout results/${file_name}_hits_kingdom=euk-bact.tsv --domtblout results/${file_name}_domtbl_kingdom=euk-bact.tsv --pfamtblout results/${file_name}_pftblout_kingdom=euk-bact.tsv ${hmm_profile} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/ALL_EUK_BACT-0722.prot

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${file_name}_hits_kingdom=archaea.tsv --domtblout results/${file_name}_domtbl_kingdom=archaea.tsv --pfamtblout results/${file_name}_pftblout_kingdom=archaea.tsv ${hmm_profile} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/GTDBarchaea2339.faa

hmmsearch --cpu $SLURM_CPUS_PER_TASK --tblout results/${file_name}_hits_kingdom=asgard.tsv --domtblout results/${file_name}_domtbl_kingdom=asgard.tsv --pfamtblout results/${file_name}_pftblout_kingdom=asgard.tsv ${hmm_profile} /shared/ifbstor1/projects/mdm_db_computations/GENOMES_DATABASE/Archaea/Asgard297_20211009.faa

# Concatenate hits table
cat results/*_hits* | grep -v "#" | awk '$5 < 1e-5' >  results/${file_name}_hits_1e-5_kingdom=all.tsv
cat results/${file_name}_hits_1e-5_kingdom=all.tsv | awk '{print $1}' > results/${file_name}_hits_1e-5_kingdom=all.ids

# Concatenate domtbl
cat results/${file_name}_domtbl_kingdom=*.tsv | grep -v "#" > results/${file_name}_domtbl_kingdom=all.tsv
cat results/${file_name}_domtbl_kingdom=all.tsv| awk 'BEGIN {print "#target\ttarget_begin\ttarget_end\thit_len\tquery_cov\ttarget_cov"}{print $1"\t"$20"\t"$21"\t"($21 - $20)"\t"($21 - $20)/$6"\t"($21 - $20)/$3}' > results/${file_name}_coord_kingdom=all.tsv

# Generate histograms
cat results/${file_name}_hits_1e-5_kingdom=all.tsv | awk '{print $5}' | awk -F'e' '{if (NF > 1) {print $2}}' | hist -x -b 100 > results/${file_name}_hits_1e-5_kingdom=all_e-value.hist
cat results/${file_name}_hits_1e-5_kingdom=all.tsv | awk '{print $6}' | hist -x -b 100 > results/${file_name}_hits_1e-5_kingdom=all_bitscore.hist

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

# Retrieve proteins
getprot-para2 -c $SLURM_CPUS_PER_TASK results/${file_name}_hits_1e-5_kingdom=all.ids  # get all proteins
mv ${file_name}_hits_1e-5_kingdom=all.ids.faa results/${file_name}_hits_1e-5_kingdom=all.faa 
seqkit seq -m ${min_len} -M ${max_len} results/${file_name}_hits_1e-5_kingdom=all.faa > results/${file_name}_hits_1e-5_len-${min_len}-${max_len}_kingdom=all.faa
n_seqs_len=$(seqkit stat results/${file_name}_hits_1e-5_len-${min_len}-${max_len}_kingdom=all.faa)  # get proteins of sufficient size
while read ID s e l qc tc; do seqkit grep -p $ID results/${file_name}_hits_1e-5_len-${min_len}-${max_len}_kingdom=all.faa | seqkit subseq -r $s:$e -R; done < <(cat results/${file_name}_coord_kingdom=all.tsv | grep -v "#" | awk -v min_q_coverage="$min_q_cov" '$5 > min_q_coverage') > results/${file_name}_hit-region_1e-5_len-${min_len}-${max_len}_qcov-gt-${min_q_cov}_kingdom=all.faa  # extract only the region hit by the profile

n_seqs=$(seqkit stat results/${file_name}_hits_1e-5_kingdom=all.faa)
n_seqs_qcov=$(seqkit stat results/${file_name}_hit-region_1e-5_qcov-gt-${min_q_cov}_kingdom=all.faa)
echo "$n_seqs sequences found in the database." >> results/${file_name}_hits_kingdom=all.report
seqkit fx2tab --length --name results/${file_name}_hits_1e-5_kingdom=all.faa | awk '{print $1"\t"$NF}' > results/${file_name}_hits_1e-5_kingdom=all_len.tsv
cat results/${file_name}_hits_1e-5_kingdom=all_len.tsv | awk '{print $2}' | hist -x -b 100 > results/${file_name}_hits_1e-5_kingdom=all_len.hist 
echo "$n_seqs_len sequences with ${min_len} < length < ${max_len}." >> results/${file_name}_hits_kingdom=all.report

# mmseqs
mmseqs easy-cluster results/${file_name}_hit-region_1e-5_len-${min_len}-${max_len}_qcov-gt-${min_q_cov}_kingdom=all.faa results/${file_name}_hit-region_80-80_kingdom=all tmp -c 0.80 --min-seq-id 0.80 --threads 20 --cov-mode 0

# Align extracted regions
mafft --thread $SLURM_CPUS_PER_TASK --reorder --localpair results/${file_name}_hit-region_80-80_kingdom=all_rep_seq.fasta > results/${file_name}_hit-region_80-80_kingdom=all_rep_seq.afa

# Move raw to raw and report files (histograms, report etc.) to reports
mv results/*=euk-bact* results/*=archaea* results/*=asgard* results/raw
mv results/*.hist results/*len.tsv results/*.report results/reports

echo "Done!" >> results/${file_name}_hits_kingdom=all.report
