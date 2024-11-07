#!/bin/bash
#requires GATK (Genome Analysis Toolkit: v4.3.0.0) 

# define variables
input_path=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/01.remove_unmapped_reads

output_path=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses/02.add_readgroups

samples_path=/home/rfuller/data/chloroplast_raw_seqs_July2022/ref_guided_algn_rhododendron/micranthum_analyses


# parallel command with GATK
parallel --jobs 5 "gatk AddOrReplaceReadGroups -I ${input_path}/{}_coordsort_mappedonly.bam -O ${output_path}/{}_sort_mappedonly_RG.bam --RGID {} --RGLB Lib1 --RGPL ILLUMINA --RGPU H2VTHDSX5 --RGSM {}" :::: ${samples_path}/samples_cpDNA_skim.txt
