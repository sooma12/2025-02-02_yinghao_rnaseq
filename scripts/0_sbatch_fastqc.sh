#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=fastqc_rnaseq
#SBATCH --time=02:00:00
#SBATCH -N 1
#SBATCH -n 2
#SBATCH --output=/work/geisingerlab/Mark/rnaSeq/2025-02-02_yh_bsub/logs/%x-%j.log
#SBATCH --error=/work/geisingerlab/Mark/rnaSeq/2025-02-02_yh_bsub/logs/%x-%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=soo.m@northeastern.edu

echo "Starting fastqc SBATCH script $(date)"

echo "Loading environment and tools"
#fastqc requires OpenJDK/19.0.1
module load OpenJDK/19.0.1
module load fastqc/0.11.9
source ./config.cfg

echo "fastq file directory: $FASTQDIR_UNTRIMMED"
echo "output directory for fastQC: $FASTQC_OUT_DIR"
echo "script directory: $SCRIPT_DIR"

mkdir -p $FASTQDIR_UNTRIMMED $FASTQC_OUT_DIR $SCRIPT_DIR

echo "Running fastqc in directory $FASTQDIR_UNTRIMMED"
fastqc $FASTQDIR_UNTRIMMED/*.fastq

echo "Cleaning up logs and output files"
mkdir -p $SCRIPT_DIR/logs
mkdir -p $FASTQC_OUT_DIR/fastqc_html $FASTQC_OUT_DIR/fastqc_zip
mv $FASTQDIR_UNTRIMMED/*fastqc.html $FASTQC_OUT_DIR/fastqc_html
mv $FASTQDIR_UNTRIMMED/*fastqc.zip $FASTQC_OUT_DIR/fastqc_zip
