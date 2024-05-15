#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 02:00:00
#SBATCH -J eggno_mapper
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se

#load modules
module load bioinfo-tools
module load eggNOG-mapper/2.1.9

# eggnog-mapper
emapper.py -i /home/sara1634/genome-analysis/analysis/braker/durian/cleaned_output_proteins.fasta -o /home/sara1634/genome-analysis/analysis/braker/durian/eggnomaper_results/Durian_annotation --itype proteins -m diamond

