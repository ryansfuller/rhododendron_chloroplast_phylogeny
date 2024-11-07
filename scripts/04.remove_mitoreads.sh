#!/bin/bash

#Uses samtools(v1.18) to remove reads that mapped to the mitochondrial genome of 
# Rhododendron simsii (#MW030508)


#CODE:
IND=$1

INPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/04.pipe_samtofastq_bwa_mitomapping

OUTPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/05.mitochondrial_removed_bams

samtools view -f 13 -h -u -@ 3 -o ${OUTPUT}/${IND}_mito-scrubbed.bam ${INPUT}/${IND}_reverted_mitomapping.bam

# -f flag of 13 corresponds to 'Read paired, Read unmapped, Mate unmapped' which will extract only \
those reads that are properly paired and unmapped while ignoring orphaned reads whose partner was \
mapped. In constrast, see flag 'f 5' where ALL unmapped reads are extracted regardless of whether \
or not they have their mate and will result in singletons in the output file.                             
