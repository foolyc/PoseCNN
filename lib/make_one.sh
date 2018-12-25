TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
echo $TF_INC

TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

CUDA_PATH=/usr/local/cuda

cd hough_voting_gpu_layer

nvcc -std=c++11 -c -o hough_voting_gpu_op.cu.o hough_voting_gpu_op.cu.cc \
	-I $TF_INC  -D_GLIBCXX_USE_CXX11_ABI=0  -I$TF_INC/external/nsync/public -D GOOGLE_CUDA=1 -x cu -Xcompiler -fPIC -arch=sm_50

g++ -std=c++11 -shared -o hough_voting_gpu.so hough_voting_gpu_op.cc \
	hough_voting_gpu_op.cu.o -I $TF_INC  -D_GLIBCXX_USE_CXX11_ABI=0 -I$TF_INC/external/nsync/public -fPIC -lcudart -lcublas $(pkg-config --cflags --libs opencv) -L $CUDA_PATH/lib64 -L$TF_LIB -ltensorflow_framework

cd ..
echo 'hough_voting_gpu_layer'
