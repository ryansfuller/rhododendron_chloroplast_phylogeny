#!/bin/bash
#mapping reads to a chloroplast reference

#requires bwa (, samtools(v1.18)
#Mapping short read (150bp paired end) genome skimming DNA sequences to Rhododendron micranthum long-read sequenced plastome NCBI#MT239365.1:

# terminal command usage w/GNU parallel: parallel --jobs 5 'sh parallel-mapping.sh {}' :::: /home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/Fu_cpDNA_analysis/dataset-H/samples_cpDNA_skim.txt

# align a single individual
REF=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/reference-fastas/MT239365.1_R.micranthum_chloroplast.fasta

# declare variables
IND=$1
FORWARD=/home/rfuller/data/chloroplast_raw_seqs_July2022/6013/trimmed_seqs_zipped/${IND}_R1_paired.fastq.gz
REVERSE=/home/rfuller/data/chloroplast_raw_seqs_July2022/6013/trimmed_seqs_zipped/${IND}_R2_paired.fastq.gz
OUTPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/bam_files/${IND}_coordsort.bam

# then align and sort
echo "Aligning $IND with bwa"
bwa mem -M -t 5 $REF $FORWARD \
$REVERSE | samtools view --threads 2 -b | \
samtools sort -@ 2 -T ${IND} > $OUTPUT
