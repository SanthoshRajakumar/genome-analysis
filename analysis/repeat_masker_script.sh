#!/bin/bash -l

#SBATCH -A uppmax2024-2-7    
#SBATCH -p core
#SBATCH -n 4                 
#SBATCH -t 00:50:00          
#SBATCH -J repeat_masked_file
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se  

# modules
module load bioinfo-tools
module load RepeatMasker/4.1.5

# commands

RepeatMasker -species durian -pa 4 -gff -dir /home/sara1634/genome-analysis/results/repeatmasker_results /home/sara1634/genome-analysis/results/pilon_results/pilon_improved_scaffold6.fasta



