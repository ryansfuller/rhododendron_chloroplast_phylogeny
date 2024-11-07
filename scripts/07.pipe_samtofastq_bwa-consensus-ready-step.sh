#!/bin/bash

#Repeat piping step similar to '04.pipe_samtofastq_bwa.sh'

#CODE
#define variables
IND=$1

INPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/06.reverted_mitomapped

OUTPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/07.consensus_ready_bam_files

TMP=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/tmp_dir


#BWA
REF=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/reference-fastas/MT239365.1_R.micranthum_chloroplast.fasta

#Code:

gatk --java-options "-Xmx2G" SamToFastq \
       -I $INPUT/${IND}_reverted_mito-scrubbed.bam \
       --FASTQ /dev/stdout \
       --INTERLEAVE true \
       --NON_PF true \
       --TMP_DIR $TMP | bwa mem -M -t 5 -p $REF /dev/stdin | \

gatk --java-options "-Xmx2G" MergeBamAlignment \
        -UNMAPPED $INPUT/${IND}_reverted_mito-scrubbed.bam \
        -ALIGNED /dev/stdin \
        --OUTPUT $OUTPUT/${IND}_consensus-ready.bam \
        -R $REF --CREATE_INDEX true --ADD_MATE_CIGAR true \
        --CLIP_OVERLAPPING_READS true --INCLUDE_SECONDARY_ALIGNMENTS false \
        --MAX_INSERTIONS_OR_DELETIONS -1 --PRIMARY_ALIGNMENT_STRATEGY MostDistant \
        --ATTRIBUTES_TO_RETAIN XS --ATTRIBUTES_TO_RETAIN XA \
        --TMP_DIR $TMP


#example usage w/GNU parallel: parallel --jobs 5 "./pipe_samtofastq_bwa-consensus-ready-step.sh" :::: samples.txt
