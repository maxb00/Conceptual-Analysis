#!/bin/bash

# Copyright (c) 2018 Uber Technologies, Inc.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# for dim in {10,50,100,500,1000,2000,5000,10000,15000,20000}
# CUDA_VISIBLE_DEVICES=0 resman -r lenet_mnist_10 -- ./train.py /data/mnist/h5/train.h5 /data/mnist/h5/test.h5 -E 100 --vsize 100 --opt 'adam' --lr 0.001 --l2 0.0001 --arch mnistlenet
# {0,100,300,350,375,380,390,400,410,420,425,450,475,500,550,600,1000}
# {200,225,250,260,275,290,300,310,325,350,375,380,390,400,410,420,425,450,475,500,550,600,1000}
# {0,200,225,250,260,275,290,300,310,325,350,375,380,390,400,410,420,425,450,475,500,550,600,650,700,750,800,850,900,950,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000}
# {2000,2100,2200,2300,2400,2500,2600,2700,2800,2900,3000}
for dim in {1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500,2600,2700,2800,2900,3000,3100,3200,3300,3400,3500,3600,3700,3800,3900,4000}
do
	if [ "$dim" = 0 ]; then
		echo dir_"$dim"
		CUDA_VISIBLE_DEVICES=`nextcuda --delay 60` resman -r lenet_mnist_ni_lr_01_dp01_dir -- ./train.py /data/mnist/h5/train_shuffled_pix_0.h5 /data/mnist/h5/test_shuffled_pix_0.h5 -E 100 --vsize $dim --opt 'sgd' --lr 0.01 --l2 0.0000 --arch mnistlenet_dir &
	else	
		echo lrb_"$dim"
		CUDA_VISIBLE_DEVICES=`nextcuda --delay 60` resman -r lenet_mnist_ni_lr_01_dp01_$dim -- ./train.py /data/mnist/h5/train_shuffled_pix_0.h5 /data/mnist/h5/test_shuffled_pix_0.h5 -E 100 --vsize $dim --opt 'sgd' --lr 0.01 --l2 0.0000 --arch mnistlenet &
	fi
done

