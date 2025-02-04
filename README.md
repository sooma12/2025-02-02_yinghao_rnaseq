# 2025-02-02_yinghao_rnaseq
RNA-seq analysis for Yinghao He Bacillus subtilis data (Feb. 2025)

Written by Mark Soo

## Reference files

Yinghao provided (B subtilis 3610): 
Genome: https://www.ncbi.nlm.nih.gov/nuccore/CP020102
Plasmid pBS32: https://www.ncbi.nlm.nih.gov/nuccore/CP020103

Downloaded fasta files for bowtie2 using bash script `download_ref_fastas.sh`, run from ./ref 

Assembled merged GTF file for annotations using:
```bash
wget -q -O "CP020102.gff3" "https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?db=nuccore&id=CP020102&report=gff3&retmode=text"
wget -q -O "CP020103.gff3" "https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?db=nuccore&id=CP020103&report=gff3&retmode=text"
cat *.gff3 > bs3610_merged.gff3
module load gffread
gffread bs3610_merged.gff3 -T -o bs3610_merged.gtf
```

Following this, the folder ./ref contains:
```text
bs3610_merged.gtf  CP020102.fasta  CP020103.fasta
```

##  Usage
Run scripts as follows.  Execute all commands from BASE_DIR defined in the config.cfg file (i.e. `cd` to that directory).
The commands below assume that all scripts are located in $BASE_DIR/scripts

1. `sbatch scripts/0_sbatch_fastqc.sh`
2. `sbatch scripts/1_sbatch_bowtie2_build_ref.sh`
3. `bash 2_make_sample_sheet.sh`  # After this command, inspect the sample sheet and ensure that files are listed correctly
4. `sbatch 3_sbatch_array_bowtie2_align.sh`
5. `sbatch 4_sbatch_samtools_to_sorted_bam.sh`
6. `sbatch 5_sbatch_featurecounts.sh`
7. `bash 6_run_multiqc.sh`



