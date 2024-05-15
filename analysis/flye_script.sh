#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 20:00:00
#SBATCH -J flye_pacbioreads_scaffold6
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se

#Load modules
module load bioinfo-tools
module load Flye/2.9.1


#command

flye --pacbio-raw /home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/pacbio_data/SRR6037732_scaffold_06.fq.gz \
--genome-size 30m \
--out-dir /home/sara1634/genome-analysis/results/flye_results \
--threads 4

