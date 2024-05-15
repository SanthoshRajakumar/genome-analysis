#!/bin/bash -l

#SBATCH -A uppmax2024-2-7    
#SBATCH -p core
#SBATCH -n 4                 
#SBATCH -t 01:00:00          
#SBATCH -J pilon_improved_scaffold6
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se  

# modules
module load bioinfo-tools
module load Pilon/1.24

#command

java -jar $PILON_HOME/pilon.jar --genome /home/sara1634/genome-analysis/results/flye_results/assembly.fasta \
      --bam /home/sara1634/genome-analysis/results/bwa_results/bwa_mapping_scaffold6_sorted.bam \
      --output pilon_improved_scaffold6 \
      --outdir /home/sara1634/genome-analysis/results/pilon_results \
      --diploid \
      --threads 4
