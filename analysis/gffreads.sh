#!/bin/sh

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 02:00:00
#SBATCH -J gffreads_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se

#load modules
module load bioinfo-tools
module load gffread/0.12.7

gffread -y /home/sara1634/genome-analysis/analysis/braker/durian/output_proteins.fasta -g /home/sara1634/genome-analysis/analysis/braker/durian/genome.fa /home/sara1634/genome-analysis/analysis/braker/durian/augustus.hints.gtf
