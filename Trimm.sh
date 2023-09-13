#!/bin/bash
#########################################################
#TRIMOMMATIC

## Directivas
#SBATCH --job-name=qtrim
#SBATCH --output=trimmomatic-%j.log
#SBATCH --error=trimmomatic-%j.err
#SBATCH -N 1
#SBATCH --mem=20GB
#SBATCH --ntasks-per-node=8
#SBATCH -t 6-00:00:00
#SBATCH -p cicese


# Ruta a TRIMMOMATIC
TRIMMOMATIC=/LUSTRE/apps/bioinformatica/Trimmomatic-0.39

#Ruta al archivo con los adaptadores
trueseq="$TRIMMOMATIC/adapters/TruSeq3-PE-2.fa"
trueseq="$TRIMMOMATIC/adapters/TruSeq3-PE.fa"
trueseq="$TRIMMOMATIC/adapters/TruSeq2-PE.fa"
trueseq="./index_i7.fa"

cd ${SLURM_SUBMIT_DIR}


java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/A20_CKDL230020997-1A_HJLJKBBXX_L3_1.fq.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/A20_CKDL230020997-1A_HJLJKBBXX_L3_2.fq.gz -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/A20_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/A30_CKDL230021000-1A_HJLJKBBXX_L3_1.fq.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/A30_CKDL230021000-1A_HJLJKBBXX_L3_2.fq.gz -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/A30_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/A40_CKDL230021003-1A_HJLJKBBXX_L3_1.fq.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/A40_CKDL230021003-1A_HJLJKBBXX_L3_2 -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/A40_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/A40_CKDL230021003-1A_HJLJKBBXX_L3_1.fq.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/A40_CKDL230021003-1A_HJLJKBBXX_L3_2 -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/A40_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/B20_CKDL230020998-1A_HJLJKBBXX_L3_1 /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/B20_CKDL230020998-1A_HJLJKBBXX_L3_2 -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/B20_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/B30_CKDL230021001-1A_HJLJKBBXX_L3_1.fg.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/B30_CKDL230021001-1A_HJLJKBBXX_L3_2.fq.gz -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/B30_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/B40_CKDL230021004-1A_HJLJKBBXX_L3_1.fq.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/B40_CKDL230021004-1A_HJLJKBBXX_L3_2.fq.gz -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/B40_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/C20_CKDL230020999-1A_HJLJKBBXX_L3_1.fq.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/C20_CKDL230020999-1A_HJLJKBBXX_L3_2.fq.gz -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/C20_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/C30_CKDL230021002-1A_HJLJKBBXX_L3_1.fq.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/C30_CKDL230021002-1A_HJLJKBBXX_L3_2.fq.gz -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/C30_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

java -jar $TRIMMOMATIC/trimmomatic-0.39.jar PE /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/C40_CKDL230021005-1A_HJLJKBBXX_L3_1.fq.gz /LUSTRE/bioinformatica_data/genomica_funcional/Raw/dinoflagelados/C40_CKDL230021005-1A_HJLJKBBXX_L3_2.fq.gz -baseout /LUSTRE/bioinformatica_data/genomica_funcional/Armando/Amphidinium/trimmomatic/C30_clean.fq.gz \
ILLUMINACLIP:$trueseq:2:30:10:8:true SLIDINGWINDOW:4:15 MINLEN:36

exit 0