#!/bin/bash

#This script removes unmapped reads, in this case nuclear/mitochondrial reads, from the output of the mapping script parallel-mapping.sh 
# requires samtools(v1.18)
#use 'SAMTOOLS view' to gather mapped reads and remove unmapped reads from a .BAM file


## GNU
#parallel --jobs 5 "samtools view --threads 5 -h -b -f 3 -o ${output_path}/{}_coordsort_mappedonly.bam ${input_path}/{}_coordsort.bam" :::: ${sample_path}/samples_reseq.txt



# CODE TO EXECUTE ON A SINGLE SAMPLE
input_path=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/bam_files

output_path=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/01.remove_unmapped_reads

sample_path=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses

#while read sample;
#do
#       samtools view \
#               --threads 8 \
#               -h
#               -b \
#               -F 4 \
#               -o ${output_path}/${sample}_mapped_only_clean_RG_deduped_coordsort.bam \
#               ${input_path}/${sample}_clean_RG_deduped_coordsort.bam;
#done < ${sample_path}/all_samples.txt
