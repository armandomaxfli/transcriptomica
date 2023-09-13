#!/bin/bash
#SBATCH -p cicese
#SBATCH --job-name=fastqc
#SBATCH --output=fastqc-%j.log
#SBATCH --error=fastqc-%j.err
#SBATCH -N 1
#SBATCH --ntasks-per-node=8
#SBATCH -t 6-00:00:00

export PATH=$PATH:/LUSTRE/apps/bioinformatica/FastQC_v0.11.7/:$PATH
module load gcc-7.2.0

fastqc /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/*.fq.gz -o /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/Fastqc -t 8

exit 0
