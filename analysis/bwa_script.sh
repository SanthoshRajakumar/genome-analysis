#!/bin/bash -l

#SBATCH -A uppmax2024-2-7    
#SBATCH -p core
#SBATCH -n 4                 
#SBATCH -t 05:00:00          
#SBATCH -J bwa_mapping_scaffold6
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se  

# modules
module load bioinfo-tools
module load bwa/0.7.17

# commands

bwa index /home/sara1634/genome-analysis/results/flye_results/assembly.fasta

bwa mem /home/sara1634/genome-analysis/results/flye_results/assembly.fasta \
/home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/illumina_data/SRR6058604_scaffold_06.1P.fastq.gz \
/home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/illumina_data/SRR6058604_scaffold_06.2P.fastq.gz > /home/sara1634/genome-analysis/results/bwa_results/bwa_mapping_scaffold6.sam


