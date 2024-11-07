#!/bin/bash



#define variables
IND=$1

INPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/05.mitochondrial_removed_bams

OUTPUT=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/06.reverted_mitomapped

gatk --java-options "-Xmx4G" RevertSam \
        -I $INPUT/${IND}_mito-scrubbed.bam \
        -O $OUTPUT/${IND}_reverted_mito-scrubbed.bam \
        -SANITIZE true \
        -MAX_DISCARD_FRACTION 0.005 \
        --ATTRIBUTE_TO_CLEAR XA \
        --ATTRIBUTE_TO_CLEAR XS \
        --ATTRIBUTE_TO_CLEAR AS \
        --SORT_ORDER queryname \
        --RESTORE_ORIGINAL_QUALITIES true \
        --REMOVE_DUPLICATE_INFORMATION true \
        --REMOVE_ALIGNMENT_INFORMATION true


#example usage with GNU parallel: parallel --jobs 5 "./make_ubam_mitoscrubbed.sh" :::: samples.txt
