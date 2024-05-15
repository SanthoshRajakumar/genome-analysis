#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 02:00:00
#SBATCH -J braker_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se

#modules

module load bioinfo-tools
module load braker/2.1.1_Perl5.24.1
module load augustus/3.2.3_Perl5.24.1
module load bamtools/2.5.1
module load blast/2.9.0+
module load GenomeThreader/1.7.0
module load samtools/1.8
module load GeneMark/4.33-es_Perl5.24.1


source $AUGUSTUS_CONFIG_COPY


#command


GENOME_PATH="/home/sara1634/genome-analysis/results/repeatmasker_results/pilon_improved_scaffold6.fasta.masked"
AUGUSTUS_CONFIG_PATH="/home/sara1634/genome-analysis/analysis/augustus_config"
AUGUSTUS_BIN_PATH="/sw/bioinfo/augustus/3.4.0/snowy/bin"
AUGUSTUS_SCRIPTS_PATH="/sw/bioinfo/augustus/3.4.0/snowy/scripts"
GENEMARK_PATH="/sw/bioinfo/GeneMark/4.33-es/snowy"

declare -a BAM_FILES=(
    "SRR6040092_scaffold_06_Aligned.sortedByCoord.out.bam"
    "SRR6040093_scaffold_06_Aligned.sortedByCoord.out.bam"
    "SRR6040094_scaffold_06_Aligned.sortedByCoord.out.bam"
    "SRR6040095_scaffold_06_Aligned.sortedByCoord.out.bam"
    "SRR6040096_scaffold_06_Aligned.sortedByCoord.out.bam"
    "SRR6040097_scaffold_06_Aligned.sortedByCoord.out.bam"
    "SRR6156066_scaffold_06_Aligned.sortedByCoord.out.bam"
    "SRR6156067_scaffold_06_Aligned.sortedByCoord.out.bam"
    "SRR6156069_scaffold_06_Aligned.sortedByCoord.out.bam"
)

BAM_DIR="/home/sara1634/genome-analysis/results/star_results"


for BAM_FILE in "${BAM_FILES[@]}"; do
    braker.pl --species=durian \
        --genome="$GENOME_PATH" \
        --bam="$BAM_DIR/$BAM_FILE" \
        --softmasking \
        --cores=8 \
        --AUGUSTUS_CONFIG_PATH="$AUGUSTUS_CONFIG_PATH" \
        --AUGUSTUS_BIN_PATH="$AUGUSTUS_BIN_PATH" \
        --AUGUSTUS_SCRIPTS_PATH="$AUGUSTUS_SCRIPTS_PATH" \
        --GENEMARK_PATH="$GENEMARK_PATH" \
        --useexisting
done
