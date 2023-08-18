# Docker image containing:
# * Verilator simulator for Snitch (/opt/snitch-rtl)
# * Spike disassembler for Snitch (/opt/snitch-spike)
# * Compiler toolchain for Snitch: llvm, clang and related binutils (/opt/snitch-llvm)
# * Upstream MLIR 16: mlir-16-opt, mlir-16-translate (installed globally)

FROM ghcr.io/pulp-platform/snitch@sha256:1a361160886ddee785ca809d0b9d30a283d0116b2761fd872ba9b69b82e2f2a6 as builder

RUN mkdir /src \
 && wget -qO- https://github.com/pulp-platform/snitch/archive/b9fe5550e26ea878fb734cfc37d161f564252305.tar.gz | \
    tar xz --strip-components 1 -C /src \
 # verilator
 && cd /src/hw/system/snitch_cluster \
 && make bin/snitch_cluster.vlt \
 # spike
 && cd /src/sw/vendor/riscv-isa-sim \
 && ./configure --prefix=/opt/snitch-spike \
 && make install \
 # clang+llvm+lld
 && mkdir -p /opt/snitch-llvm \
 && wget -qO- https://github.com/pulp-platform/llvm-project/releases/download/0.12.0/riscv32-pulp-llvm-ubuntu1804-0.12.0.tar.gz | \
    tar xz --strip-components=1 -C /opt/snitch-llvm

FROM ubuntu:18.04 as toolchain
COPY --from=builder /src/hw/system/snitch_cluster/bin/snitch_cluster.vlt /opt/snitch-rtl/bin/snitch_cluster.vlt
COPY --from=builder /opt/snitch-spike /opt/snitch-spike
COPY --from=builder /opt/snitch-llvm /opt/snitch-llvm

RUN apt-get -y update \
 && apt-get -y upgrade \
 # mlir
 && apt-get -y install wget lsb-release software-properties-common gnupg \
 && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
 && echo "\
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main \n\
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main \n\
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-16 main \n\
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-16 main\n" >> /etc/apt/sources.list \
 && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
 && apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install mlir-16-tools \
 # Misc stuff
 && apt-get -y install make \
 #
 && rm -rf /var/lib/apt/lists/*