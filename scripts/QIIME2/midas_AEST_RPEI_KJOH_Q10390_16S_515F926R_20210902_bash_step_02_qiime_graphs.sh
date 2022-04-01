#!/bin/bash
#SBATCH --job-name=midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16

source activate ~/miniconda3/envs/qiime2-2019.10

qiime

cd /export2/home/microlab/microlab/qiime/illumina_data

cp /export2/home/microlab/microlab/python_scripts/qiime/qiime_settings.ini /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/qiime_settings.txt
cp -u /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902*_bash_step_*.sh /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/

qiime diversity alpha-rarefaction \
--i-table /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_table.qza \
--m-metadata-file /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902@metadata.txt \
--o-visualization /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_alpha_rarefaction_curves.qzv \
--p-min-depth 100 \
--p-max-depth 40000


qiime diversity core-metrics-phylogenetic \
--i-table /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_table.qza \
--i-phylogeny /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_rooted-tree.qza \
--m-metadata-file /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902@metadata.txt \
--p-sampling-depth 21612 \
--output-dir /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_microbial-diversity-results


qiime taxa barplot \
--i-table /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_table.qza \
--i-taxonomy /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxonomy_NB_classifier_MiDAS_4-8-1_16S_515F926R.qza \
--m-metadata-file /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902@metadata.txt \
--o-visualization /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_barplot.qzv


mkdir /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_absolute_relative
unzip /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_barplot.qzv -d /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_absolute_relative
echo midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902 > /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_absolute_relative/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902.id
find /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902 -type f -name 'level-7.csv' -exec sh -c 'for arg do cp -- "$arg" "/export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_absolute_relative/"; done' _ {} +
cd /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_absolute_relative/
cp /export2/home/microlab/microlab/python_scripts/qiime/transpose_csv_files.py /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_absolute_relative/
python3.6 /export2/home/microlab/microlab/qiime/illumina_data/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902/midas_AEST_RPEI_KJOH_Q10390_16S_515F926R_20210902_taxa_absolute_relative/transpose_csv_files.py

source deactivate