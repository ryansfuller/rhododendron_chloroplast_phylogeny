#!/bin/bash

#Purpose:Pipe reads through BWA via GATK. 
#Details: Pipe the chloroplast-mapped/read-group updated reads through gatk by first converting back 
#to fastq, then feeding the fastq files to BWA. GATK MergeBamAlignment can then take the 
#output of BWA and create a new output BAM file while preserving the data that may otherwise 
#be lost whe converting to FASTQ 

#BEGIN CODE
#define variables
IND=$1

INPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/03.unmapped_bams

OUTPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/04.pipe_samtofastq_bwa_mitomapping

TMP=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/tmp_dir


#BWA
REF=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/reference-fastas/Rh.simsii_mitochondrion_genome_MW030508.fasta

#Code:

gatk --java-options "-Xmx2G" SamToFastq \
       -I ${INPUT}/${IND}_reverted-sam_qsort.bam \
       --FASTQ /dev/stdout \
       --INTERLEAVE true \
       --NON_PF true \
       --TMP_DIR ${TMP} | bwa mem -M -t 5 -p ${REF} /dev/stdin | \

gatk --java-options "-Xmx2G" MergeBamAlignment \
        -UNMAPPED ${INPUT}/${IND}_reverted-sam_qsort.bam \
        -ALIGNED /dev/stdin \
        --OUTPUT ${OUTPUT}/${IND}_reverted_mitomapping.bam \
        -R ${REF} --CREATE_INDEX true --ADD_MATE_CIGAR true \
        --CLIP_OVERLAPPING_READS true --INCLUDE_SECONDARY_ALIGNMENTS true \
        --MAX_INSERTIONS_OR_DELETIONS -1 --PRIMARY_ALIGNMENT_STRATEGY MostDistant \
        --ATTRIBUTES_TO_RETAIN XS --ATTRIBUTES_TO_RETAIN XA \
        --TMP_DIR ${TMP}
