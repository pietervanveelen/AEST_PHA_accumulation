#!/bin/bash
#SBATCH --job-name=midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16

source activate ~/miniconda3/envs/qiime2-2019.10

cd /export2/home/microlab/microlab/qiime/illumina_data

mkdir -p /export2/home/microlab/microlab/qiime/illumina_data/temp
export TMPDIR=/export2/home/microlab/microlab/qiime/illumina_data/temp

mkdir -p midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902

mkdir -p midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/raw_data

qiime

cp -u midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902*_bash_step_*.sh /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/
cd /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902

qiime tools import \
--type MultiplexedPairedEndBarcodeInSequence \
--input-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/raw_data \
--output-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_paired_end_sequences.qza

qiime cutadapt demux-paired \
--i-seqs /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_paired_end_sequences.qza \
--m-forward-barcodes-file /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902@metadata.txt \
--m-forward-barcodes-column BarcodeSequence \
--p-error-rate 0 \
--o-per-sample-sequences /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_demux.qza \
--o-untrimmed-sequences /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_untrimmed.qza \
--verbose

qiime demux summarize \
--i-data /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_demux.qza \
--o-visualization /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_demux.qzv 

qiime cutadapt trim-paired \
--i-demultiplexed-sequences /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_demux.qza \
--p-front-f GTGYCAGCMGCCGCGGTAA \
--p-front-r CCGYCAATTYMTTTRAGTTT \
--p-discard-untrimmed \
--o-trimmed-sequences /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_trimmed-demux-seqs.qza

qiime demux summarize \
--i-data /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_trimmed-demux-seqs.qza \
--o-visualization /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_trimmed-demux-seqs.qzv 

qiime dada2 denoise-paired \
--i-demultiplexed-seqs /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_trimmed-demux-seqs.qza \
--p-trim-left-f 2 \
--p-trim-left-r 2 \
--p-trunc-len-f 190 \
--p-trunc-len-r 200 \
--p-max-ee-f 4 \
--p-max-ee-r 4 \
--o-table /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_table.qza \
--o-representative-sequences /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_representative_sequences.qza \
--o-denoising-stats /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_denoising_stats.qza \
--p-n-threads 16 

qiime metadata tabulate \
--m-input-file /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_denoising_stats.qza \
--o-visualization /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_denoising_stats.qzv

qiime feature-table summarize \
--i-table /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_table.qza \
--m-sample-metadata-file /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902@metadata.txt \
--o-visualization /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_table.qzv

qiime feature-table tabulate-seqs \
--i-data /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_representative_sequences.qza \
--o-visualization /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_representative_sequences.qzv

qiime alignment mafft \
--i-sequences /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_representative_sequences.qza \
--o-alignment /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_aligned-rep-seqs.qza \
--p-n-threads 16 

qiime alignment mask \
--i-alignment /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_aligned-rep-seqs.qza \
--o-masked-alignment /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_masked_aligned-rep-seqs.qza

qiime phylogeny fasttree \
--i-alignment /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_masked_aligned-rep-seqs.qza \
--o-tree /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_unrooted-tree.qza \
--p-n-threads 16

qiime phylogeny midpoint-root \
--i-tree /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_unrooted-tree.qza \
--o-rooted-tree /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_rooted-tree.qza

qiime feature-classifier classify-sklearn \
--i-classifier /export2/home/microlab/microlab/qiime_classifiers/NB_classifier_MiDAS_4-8-1_16S_515F926R.qza \
--i-reads /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_representative_sequences.qza \
--o-classification /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxonomy_NB_classifier_MiDAS_4-8-1_16S_515F926R.qza \
--p-n-jobs 16

qiime metadata tabulate \
--m-input-file /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxonomy_NB_classifier_MiDAS_4-8-1_16S_515F926R.qza \
--o-visualization /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxonomy_NB_classifier_MiDAS_4-8-1_16S_515F926R.qzv

qiime tools export \
--input-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_representative_sequences.qza \
--output-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902

qiime tools export \
--input-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_table.qza \
--output-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902

qiime tools export \
--input-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_rooted-tree.qza \
--output-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902

qiime tools export \
--input-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxonomy_NB_classifier_MiDAS_4-8-1_16S_515F926R.qza \
--output-path /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/

mv /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/dna-sequences.fasta /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_dna-sequences.fasta
mv /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/feature-table.biom /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_feature-table.biom
mv /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/tree.nwk /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_tree.nwk
mv /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/taxonomy.tsv /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxonomy.tsv

unzip /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_demux.qzv -d /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902
find /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902 -type f -name 'forward-seven-number-summaries.csv' -exec sh -c 'for arg do cp -- "$arg" "/export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_forward-seven-number-summaries.csv"; done' _ {} +
find /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902 -type f -name 'reverse-seven-number-summaries.csv' -exec sh -c 'for arg do cp -- "$arg" "/export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_reverse-seven-number-summaries.csv"; done' _ {} +
unzip /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_denoising_stats.qza -d /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902
find /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902 -type f -name 'stats.tsv' -exec sh -c 'for arg do cp -- "$arg" "/export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/CHECK_midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_stats.tsv"; done' _ {} +

source deactivate