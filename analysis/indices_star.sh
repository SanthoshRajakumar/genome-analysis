#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 6
#SBATCH -t 02:00:00
#SBATCH -J star_script
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se


#Load modules
module load bioinfo-tools
module load star/2.7.11a



# command

#for indices

GENOME_DIR="/home/sara1634/genome-analysis/results/genome_dir_star"
FASTA_FILE="/home/sara1634/genome-analysis/results/repeatmasker_results/pilon_improved_scaffold6.fasta.masked"
STAR --runThreadN 6 \
     --runMode genomeGenerate \
     --genomeDir $GENOME_DIR \
     --genomeFastaFiles $FASTA_FILE \
     --genomeSAindexNbases 11     
