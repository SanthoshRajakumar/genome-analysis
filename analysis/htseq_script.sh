#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 2:00:00
#SBATCH -J htseq_count
#SBATCH --mail-type=ALL
#SBATCH --mail-user santhosh.rajakumar.1634@student.uu.se

# Load modules
module load bioinfo-tools
module load htseq/2.0.2
module load samtools/1.20

BAM_DIR="/home/sara1634/genome-analysis/results/star_results"
GFF_FILE="/home/sara1634/genome-analysis/analysis/braker/durian/corrected_augustus.hints.gff"
OUTPUT_DIR="/home/sara1634/genome-analysis/results/htseq_results"


# HTSeq-Count 
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6040092_scaffold_06_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6040092_counts.txt
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6040093_scaffold_06_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6040093_counts.txt
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6040094_scaffold_06_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6040094_counts.txt
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6040095_scaffold_06_1P_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6040095_counts.txt
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6040096_scaffold_06_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6040096_counts.txt
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6040097_scaffold_06_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6040097_counts.txt
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6156066_scaffold_06_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6156066_counts.txt
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6156067_scaffold_06_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6156067_counts.txt
htseq-count -f bam -s no -t gene -i gene_id $BAM_DIR/SRR6156069_scaffold_06_Aligned.sortedByCoord.out.bam $GFF_FILE > $OUTPUT_DIR/SRR6156069_counts.txt

