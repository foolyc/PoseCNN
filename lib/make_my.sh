TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
echo $TF_INC

TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

CUDA_PATH=/usr/local/cuda

cd hough_voting_layer

g++ -std=c++11 -c -o Hypothesis.o Hypothesis.cpp -fPIC

g++ -std=c++11 -c -o thread_rand.o thread_rand.cpp -fPIC

g++ -std=c++11 -shared -o hough_voting.so hough_voting_op.cc \
	Hypothesis.o thread_rand.o -I $TF_INC -D_GLIBCXX_USE_CXX11_ABI=0 -I$TF_INC/external/nsync/public \
        -fPIC -lcudart $(pkg-config --cflags --libs opencv) -lgomp -lnlopt -L $CUDA_PATH/lib64 -L$TF_LIB -ltensorflow_framework

cd ..
echo 'hough_voting_layer'
