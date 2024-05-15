#!/bin/bash

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J quast_scaffold6
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se

#Load modules
module load bioinfo-tools
module load quast/5.0.2

#command

quast.py -o /home/sara1634/genome-analysis/results/quast_results /home/sara1634/genome-analysis/results/flye_results/assembly.fasta

