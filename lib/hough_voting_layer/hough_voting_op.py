import tensorflow as tf
import os.path as osp
import sys
sys.path.append("/usr/lib/x86_64-linux-gnu")
tf.load_op_library("/usr/lib/x86_64-linux-gnu/libopencv_imgproc.so")
tf.load_op_library("/usr/lib/x86_64-linux-gnu/libopencv_calib3d.so")
tf.load_op_library("/usr/lib/x86_64-linux-gnu/libopencv_core.so")
tf.load_op_library("/usr/lib/x86_64-linux-gnu/libopencv_imgproc.so")
print "ok"
print tf.sysconfig.get_include()
print tf.sysconfig.get_lib()

filename = osp.join(osp.dirname(__file__), 'hough_voting.so')
_hough_voting_module = tf.load_op_library(filename)
hough_voting = _hough_voting_module.houghvoting
hough_voting_grad = _hough_voting_module.houghvoting_grad
