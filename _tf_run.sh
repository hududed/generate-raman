#!/bin/bash
#SBATCH --account=rd-hea
#SBATCH --time=12:00:00
#SBATCH --job-name=tf-benchmark
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --output=tensorflow_%A.log
#SBATCH --mem=8G
#SBATCH --partition=teton-gpu
#SBATCH --gres=gpu:p100:1

#echo "Load Modules:"
#module load swset/2018.05
#module load cuda/10.1.243
#module load miniconda3/4.12.0

#echo "Check GPU Allocation:"
#echo "Running nvidia-smi:"
#srun nvidia-smi -L
#nvcc --version

echo "Activate Conda Environment"
source deactivate
source activate /pfs/tc1/project/rd-hea/hwahab/tf 
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
#python --version

echo "- - - - - - - - - - - - - - - - - - - - -"
#python -m wandb login $WANDBKEY
srun python 02-benchmark.py
echo "- - - - - - - - - - - - - - - - - - - - -"

echo "Deactivate Conda:"
source deactivate

echo "Done"
