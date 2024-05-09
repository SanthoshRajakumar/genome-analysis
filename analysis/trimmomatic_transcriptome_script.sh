#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:55:00
#SBATCH -J trimmomatic_transcriptome
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se


#Load modules
module load bioinfo-tools
module load trimmomatic

# Path to the trimomatic.jar
trim_path='/sw/apps/bioinfo/trimmomatic/0.36/rackham/trimmomatic.jar'

# Path to input
fwd_input_path='/home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/transcriptome/untrimmed/SRR6040095_scaffold_06.1.fastq.gz'
rev_input_path='/home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/transcriptome/untrimmed/SRR6040095_scaffold_06.2.fastq.gz'

# Output path and baseout
output_dir='/home/sara1634/genome-analysis/results/trimmomatic_results/'

output_base='SRR6040095_scaffold_06'

#command

java -jar $trim_path PE \
    -threads 2 \
    $fwd_input_path \
    $rev_input_path \
    $output_dir$output_base"_1P.fastq.gz" \
    $output_dir$output_base"_1U.fastq.gz" \
    $output_dir$output_base"_2P.fastq.gz" \
    $output_dir$output_base"_2U.fastq.gz" \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36

