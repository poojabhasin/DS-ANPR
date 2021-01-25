## ANPR (Automatic Number Plate Recognition)

Automatic number-plate recognition is a technology that uses optical character recognition on images to read vehicle registration plates to create vehicle location data.

![DS-ANPR](resources/anpr.png)

## Citations

* https://platerecognizer.com/camera-setup-for-best-anpr/

## Index

1. [Introduction](#Introduction)
2. [Deepstream Setup](#Deepstream-Setup)
    1. [Install System Dependencies](#Install-System-Dependencies)
    2. [Install Deepstream](#Install-Deepstream)
3. [Running the Application](#Running-the-Application)
    1. [Clone the repository](#Cloning-the-repository)
    2. [Run with different input sources](#Run-with-different-input-sources)

## Introduction

ANPR Application consists of two parts. An Intelligent Video Analytics Pipeline powered by Deepstream and NVIDIA Jetson Nano and an ANPR key which can  be generated through plate recognizer.
Below is the link for generating the key. 

* https://app.platerecognizer.com/start/stream

Note - Free-trial license supports 2500 lookups/month of Plate recognizer sanpshot API. Please keep in mind that free trial support 1 image per second.

## Deepstream Setup

This post assumes you have a fully functional Jetson device. If not, you can refer the documentation [here](https://docs.nvidia.com/jetson/jetpack/install-jetpack/index.html).

### 1. Install System Dependencies

```sh
sudo apt install \
libssl1.0.0 \
libgstreamer1.0-0 \
gstreamer1.0-tools \
gstreamer1.0-plugins-good \
gstreamer1.0-plugins-bad \
gstreamer1.0-plugins-ugly \
gstreamer1.0-libav \
libgstrtspserver-1.0-0 \
libjansson4=2.11-1
```

### 2. Install Deepstream

Download the DeepStream 5.0.1 Jetson Debian package `deepstream-5.0_5.0.1-1_arm64.deb`, to the Jetson device from [here](https://developer.nvidia.com/assets/Deepstream/5.0/ga/secure/deepstream_sdk_5.0.1_amd64.deb). Then enter the command:

```sh
sudo apt-get install ./deepstream-5.0_5.0.1-1_arm64.deb
```

## Running the Application

### 1. Clone the repository

This is a straightforward step, however, if you are new to git or git-lfs, I recommend glancing threw the steps.

First, install git and git-lfs

```sh
sudo apt install git git-lfs
```

Next, clone the repository

```sh
# Using HTTPS
git clone https://github.com/poojabhasin/DS-ANPR.git
```

Finally, enable lfs and pull the model

```sh
git lfs install
git lfs pull
```

### 2. Run with different input sources

The computer vision part of the solution can be run on one or many input sources of multiple types, all powered using NVIDIA Deepstream.

First, build the application by running the following command:

```sh
make clean && make -j$(nproc)
```

This will generate the binary called `ds-anpr-app`. This is a one-time step and you need to do this only when you make source-code changes.

Next, create a file called `inputsources.txt` and paste the path of videos or rtsp url.

```sh
file:///home/pooja/DCMainGate_20201103_161120.mp4
rtsp://admin:admin@172.16.1.1:554/streaming/channels/101
```

Now, run the application by running the following command:

```sh
./ds-anpr-app
```

Finally, add the url in `inputsources.txt` and start `./ds-anpr-app`.
