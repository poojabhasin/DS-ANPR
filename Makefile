APP:= ds-anpr-app

CXX:= g++ -std=c++17
#NVCC:=/usr/local/cuda/bin/nvcc

TARGET_DEVICE:= $(shell g++ -dumpmachine | cut -f1 -d -)

NVDS_VERSION:=5.0

LIB_INSTALL_DIR?=/opt/nvidia/deepstream/deepstream-$(NVDS_VERSION)/lib/

ifeq ($(TARGET_DEVICE),aarch64)
  CFLAGS:= -DPLATFORM_TEGRA
endif

SRCS:= $(wildcard ds-src/*.c)
SRCS+= $(wildcard ds-src/*.cpp)
SRCS+= $(wildcard utils/*.cpp)

INCS:= $(wildcard ds-src/*.h)

INCS+= $(wildcard utils/*.h)

PKGS:= gstreamer-1.0 json-glib-1.0 opencv4

OBJS:= $(SRCS:.cpp=.o)

CFLAGS+= -I/opt/nvidia/deepstream/deepstream-5.0/sources/includes \
		 -DDS_VERSION_MINOR=0 -DDS_VERSION_MAJOR=5

CFLAGS+= `pkg-config --cflags $(PKGS)`

LIBS:= `pkg-config --libs $(PKGS)`

LIBS+= -L$(LIB_INSTALL_DIR) -L/usr/local/cuda/lib64 -lcudart \
	   -lnvdsgst_meta -lnvds_meta -lnvdsgst_helper -lnvds_logger -lm -lrt \
       -Wl,-rpath,$(LIB_INSTALL_DIR)

LIBS+= -L$(LIB_INSTALL_DIR) -lnvdsgst_meta -lnvds_meta -lnvdsgst_helper -lnvdsgst_smartrecord -lnvds_utils -lnvds_msgbroker -lm \
       -lgstrtspserver-1.0 -lgstrtp-1.0 -Wl,-rpath,$(LIB_INSTALL_DIR) -lnvbufsurface -lnvbufsurftransform

LIBS+= -lcurl -lgnutls -luuid -lstdc++fs

LIBS+= -pthread

LIBS+= -lconfig++

LIBS+=  -lboost_system -lboost_filesystem -lboost_chrono -lboost_thread

all: iris 

iris: $(APP)

%.o: %.cpp $(INCS) Makefile
	$(CXX) -c -o $@ $(CFLAGS) $<

$(APP): $(OBJS) Makefile
	$(CXX) -o $(APP) $(OBJS) $(LIBS)


clean:
	rm -rf $(OBJS) $(APP)