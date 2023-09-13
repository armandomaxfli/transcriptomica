#!/bin/bash
#SBATCH -p cicese
#SBATCH --job-name=multifqc 
#SBATCH --output=trm-%j.log 
#SBATCH --error=trm-%j.err 
#SBATCH -N 2
#SBATCH --mem=100GB
#SBATCH --ntasks-per-node=24 
#SBATCH -t 06-00:00:00

export PATH=/LUSTRE/apps/Anaconda/2023/miniconda3/bin:$PATH 
source activate qiime2-2023.2

multiqc /LUSTRE/bioinformatica_data/genomica_funcional/Paulina/mano_leon/experimental/todas/fastQC/*zip -o /LUSTRE/bioinformatica_data/genomica_funcional/Paulina/mano_leon/experimental/todas/fastQC/multiQC --data-format json --export