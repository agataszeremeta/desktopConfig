# **Tensorflow GPU in Docker Installation Guide for Old CPU Based Computer Without AVX Instructions**

The following is a guide to building a Tensorflow wheel file and installing it in a Docker cudagl image for CPU systems that do not support AVX instructions, as required for newer Tensorflow-gpu installs 

Notes:
- Tested with tensorflow-gpu==2.3.1, CUDA 10.1, python3
- Review system compatibilites. At time or writing, required tensorflow-gpu==2.3.1 but tensorflow-gpu >= 1.6 only compatible with CPUs supporting AVX Instructions
- Tensorflow <= 1.5 only compatible on Ubuntu 16.04 with CUDA 9 and cuDNN 7


## **To create the Tensorflow wheel file:**

 1. Pull the latest Tensorflow GPU Developer Docker image and run the container:

```
docker pull tensorflow/tensorflow:devel-gpu
docker run --gpus all -it -w /tensorflow -v $PWD:/mnt -e HOST_PERMS="$(id -u):$(id -g)" \
    tensorflow/tensorflow:devel-gpu bash
```

2. Within the container, change directory to *tensorflow_src* and pull/checkout the desired tensorflow version to build using *git*. *git pull* will call for the latest available version. To specify version, use *git checkout v<version>*. To verify pulled version, use *git status*. 

```
cd /tensorflow_src
git pull
# git checkout v<version> 
git checkout v2.3.1
```

```
git status
```

3. Configure the build. Answer the prompts or press Enter through all to use defaults.

```
./configure
```

4. Start the build. Set bazel to build using available settings for particular system. (Expect this to take several hours). To limit number of cores used (and avoid crashes), limit number of jobs using *-j <cores available -1>* flag.

```
bazel build --copt=-march=native --config=cuda //tensorflow/tools/pip_package:build_pip_package
```

5. Create the wheel (.whl) package from the build:

```
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /mnt  # create package
```

6. Install tensorflow from the built wheel file to test success. Continue to test in the same Docker container. 

```
pip3 uninstall tensorflow # Remove current installed versions of Tensorflow
cd /mnt
pip3 install tensorflow:... # Use tab to complete name of .whl file
```

7. Copy wheel file to host directory. Confirm file successfully copied through file explorer.

```
# cp tensorflow-<version>-<tags>.whl /mounted
cp tensorflow-2.3.1-cp36-cp36m-linux_x86_64.whl /mounted
```

8. Install build Tensorflow wheel package in desired Docker container by copying .whl file. Install similarly to how installed in Tensorflow container. 

