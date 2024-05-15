#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 6
#SBATCH -t 02:00:00
#SBATCH -J star_script
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se

# Load modules
module load bioinfo-tools
module load star/2.7.11a

# Set directories
GENOME_DIR="/home/sara1634/genome-analysis/results/genome_dir_star"
OUTPUT_DIR="/home/sara1634/genome-analysis/results/star_results"
TRIMMED_DIR="/home/sara1634/genome-analysis/raw_data/4_Tean_Teh_2017/transcriptome/trimmed"
SPECIAL_TRIMMED_DIR="/home/sara1634/genome-analysis/results/trimmomatic_results"

# List of read pairs
declare -a read_pairs=(
"SRR6040095_scaffold_06_1P.fastq.gz SRR6040095_scaffold_06_2P.fastq.gz"
"SRR6040092_scaffold_06.1.fastq.gz SRR6040092_scaffold_06.2.fastq.gz"
"SRR6040093_scaffold_06.1.fastq.gz SRR6040093_scaffold_06.2.fastq.gz"
"SRR6040094_scaffold_06.1.fastq.gz SRR6040094_scaffold_06.2.fastq.gz"
"SRR6040096_scaffold_06.1.fastq.gz SRR6040096_scaffold_06.2.fastq.gz"
"SRR6040097_scaffold_06.1.fastq.gz SRR6040097_scaffold_06.2.fastq.gz"
"SRR6156066_scaffold_06.1.fastq.gz SRR6156066_scaffold_06.2.fastq.gz"
"SRR6156067_scaffold_06.1.fastq.gz SRR6156067_scaffold_06.2.fastq.gz"
"SRR6156069_scaffold_06.1.fastq.gz SRR6156069_scaffold_06.2.fastq.gz"
)

# Loop through each pair and execute STAR
for pair in "${read_pairs[@]}"; do
    IFS=' ' read -r -a files <<< "$pair"
    if [[ "${files[0]}" == "SRR6040095_scaffold_06_1P.fastq.gz" ]]; then
        READ1="${SPECIAL_TRIMMED_DIR}/${files[0]}"
        READ2="${SPECIAL_TRIMMED_DIR}/${files[1]}"
    else
        READ1="${TRIMMED_DIR}/${files[0]}"
        READ2="${TRIMMED_DIR}/${files[1]}"
    fi
    OUT_PREFIX="${OUTPUT_DIR}/$(basename ${files[0]%%.*})_"

    STAR --runThreadN 6 \
         --genomeDir $GENOME_DIR \
         --readFilesIn $READ1 $READ2 \
         --readFilesCommand zcat \
         --outFileNamePrefix $OUT_PREFIX \
         --outSAMtype BAM SortedByCoordinate \
         --outSAMunmapped Within \
         --outSAMattributes Standard
done

