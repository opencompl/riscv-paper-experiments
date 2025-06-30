FROM ghcr.io/pulp-platform/snitch_cluster:main as builder

RUN git clone --recursive https://github.com/pulp-platform/snitch_cluster.git /src \
 && cd /src \
 && git reset --hard c757830632b7f7cd7d8ed511e5cc1eb662b43b37 \
 && git submodule update \
 # verilator model
 && cd /src/target/snitch_cluster \
 && make verilator \
 # snitch runtime
 && cd /src/target/snitch_cluster \
 && make DEBUG=ON sw \

FROM ubuntu:22.04 as toolchain
ENV DEBIAN_FRONTEND=noninteractive
# Runtime dependencies
COPY --from=builder /src/target/snitch_cluster/bin/snitch_cluster.vlt /opt/snitch-rtl/bin/snitch_cluster.vlt
COPY --from=builder /opt/snitch-spike /opt/snitch-spike
COPY --from=builder /opt/snitch-llvm /opt/snitch-llvm
COPY --from=builder /opt/python3.11 /opt/python3.11
COPY --from=builder /src/util/trace /opt/snitch_cluster/util/trace
# Compile and link time dependencies
COPY --from=builder /src/sw/snRuntime /opt/snitch_cluster/sw/snRuntime
COPY --from=builder /src/target/snitch_cluster/sw/runtime/rtl /opt/snitch_cluster/target/snitch_cluster/sw/runtime/rtl
COPY --from=builder /src/target/snitch_cluster/sw/runtime/common /opt/snitch_cluster/target/snitch_cluster/sw/runtime/common
COPY --from=builder /src/sw/math/ /opt/snitch_cluster/sw/math/
# Transitive deps, this stuff must go at some point
COPY --from=builder /src/sw/deps/riscv-opcodes /opt/snitch_cluster/sw/deps/riscv-opcodes
COPY --from=builder /src/sw/deps/printf /opt/snitch_cluster/sw/deps/printf

RUN apt-get -y update \
 && apt-get -y upgrade \
 # python runtime dependencies
 && apt-get -y install \
      wget \
      zlib1g \
      libncurses5 \
      libgdbm5 \
      libnss3 \
      libssl1.1 \
      libreadline7 \
      libffi6 \
      libsqlite3-0 \
      bzip2 \
      build-essential \
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
 # misc stuff
 && apt-get -y install make \
 # make sure we have the latest git version,
 # otherwise github actions would have lots of issues
 # (e.g.: with recursive clones)
 && add-apt-repository -y ppa:git-core/ppa \
 && apt-get -y update \
 && apt-get -y install git \
 # cleanup
 && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# Make our own python3.11 available for current $USER:
ENV PATH "/opt/python3.11/bin:${PATH}"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
