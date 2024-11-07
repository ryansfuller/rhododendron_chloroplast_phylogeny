#!/bin/bash

#convert a mapped bam file to an unmapped bam file in preparation for conversion to fastq and downstream mapping
# see GATK best practices for handling read data: https://gatk.broadinstitute.org/hc/en-us/articles/4403687183515--How-to-Generate-an-unmapped-BAM-from-FASTQ-or-aligned-BAM

#define variables
IND=$1

INPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/02.add_readgroups

OUTPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/03.unmapped_bams


gatk --java-options "-Xmx4G" RevertSam \
    -I ${INPUT}/${IND}_sort_mappedonly_RG.bam \
    -O ${OUTPUT}/${IND}_reverted-sam_qsort.bam \
    -SANITIZE true \
    -MAX_DISCARD_FRACTION 0.005 \
    --ATTRIBUTE_TO_CLEAR XA \
    --ATTRIBUTE_TO_CLEAR XS \
    --ATTRIBUTE_TO_CLEAR AS \
    --SORT_ORDER queryname \
    --RESTORE_ORIGINAL_QUALITIES true \
    --REMOVE_DUPLICATE_INFORMATION true \
    --REMOVE_ALIGNMENT_INFORMATION true



#example usage for GNU parallel: parallel --jobs 5 "./make_ubam.sh" :::: samples.txt
