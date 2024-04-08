#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:55:00
#SBATCH -J fastqc_combined                
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se

# Load modules
module load bioinfo-tools
module load FastQC/0.11.5

# My commands

for filename in /home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/transcriptome/trimmed/*.fastq.gz            
    do
      	fastqc $filename -o /home/sara1634/genome-analysis/results/fastqc_results/;
    done

for filename in /home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/transcriptome/untrimmed/*.fastq.gz
    do
      	fastqc $filename -o /home/sara1634/genome-analysis/results/fastqc_results/;
    done

for filename in /home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/illumina_data/*.fastq.gz
    do
      	fastqc $filename -o /home/sara1634/genome-analysis/results/fastqc_results/;
    done

for filename in /home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/pacbio_data/*.fastq.gz
    do
      	fastqc $filename -o /home/sara1634/genome-analysis/results/fastqc_results/;
    done




