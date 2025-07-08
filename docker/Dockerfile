#-------------------------------------------------------------------------------
# Stage 1: Builder
# Clones the repository and builds the necessary artifacts.
#-------------------------------------------------------------------------------
FROM ghcr.io/pulp-platform/snitch_cluster:main AS builder

# Clone the snitch_cluster repository into /repo
RUN git clone -b fix-deps https://github.com/pulp-platform/snitch_cluster /repo

WORKDIR /repo

# Patch .gitmodules to replace SSH URLs with HTTPS
RUN sed -i 's|git@github.com:|https://github.com/|g' .gitmodules

# Initialize and update submodules (now using HTTPS)
RUN git submodule update --init --recursive

RUN make -C target/snitch_cluster verilator

RUN make -C target/snitch_cluster DEBUG=ON sw

WORKDIR /

RUN cd /repo/target/snitch_cluster/work-vlt/riscv-isa-sim \
  && ./configure --prefix=/opt/snitch-spike \
  && make install

WORKDIR /src

RUN curl -L -o riscv32-snitch-llvm-ubuntu2204-15.0.0-snitch-0.2.0.tar.gz https://github.com/pulp-platform/llvm-project/releases/download/15.0.0-snitch-0.2.0/riscv32-snitch-llvm-ubuntu2204-15.0.0-snitch-0.2.0.tar.gz

RUN tar -xzf riscv32-snitch-llvm-ubuntu2204-15.0.0-snitch-0.2.0.tar.gz -C /src

# # Combine all build steps into a single RUN command to leverage caching.
# # If the repo URL or commit hash doesn't change, this layer remains cached.
# RUN git clone --recursive https://github.com/pulp-platform/snitch_cluster.git . \
#    && git reset --hard c757830632b7f7cd7d8ed511e5cc1eb662b43b37 \
#    && git submodule update --init --recursive \
#    # Build the verilator model and software in the same layer
#    && cd /src/target/snitch_cluster \
#    && make verilator \
#    && make DEBUG=ON sw

#-------------------------------------------------------------------------------
# Stage 2: Final Toolchain Image
# Creates the final, lean image by copying artifacts from the builder
# and installing only necessary runtime dependencies.
#-------------------------------------------------------------------------------
FROM ubuntu:22.04 AS toolchain

# Set this environment variable early.
ENV DEBIAN_FRONTEND=noninteractive

# Combine related COPY commands to reduce image layers.
# Copying parent directories is more efficient than many individual sub-directories.

#COPY --from=builder /src/target/snitch_cluster/bin/snitch_cluster.vlt /opt/snitch-rtl/bin/snitch_cluster.vlt
COPY --from=builder /repo/target/snitch_cluster/bin/snitch_cluster.vlt /opt/snitch-rtl/bin/snitch_cluster.vlt

COPY --from=builder /opt/snitch-spike /opt/snitch-spike

#COPY --from=builder /opt/snitch-llvm /opt/snitch-llvm
COPY --from=builder /src/riscv32-snitch-llvm-ubuntu2204-15.0.0-snitch-0.2.0 /src/snitch-llvm

#COPY --from=builder /opt/python3.11 /opt/python3.11

#COPY --from=builder /src/util/trace /opt/snitch_cluster/util/trace
COPY --from=builder /repo/util/trace /opt/snitch_cluster/util/trace

# Copy the entire 'sw' directory at once instead of its individual sub-directories.
#COPY --from=builder /src/sw /opt/snitch_cluster/sw
COPY --from=builder /repo/sw /opt/snitch_cluster/sw

# Copy the entire runtime directory at once.
#COPY --from=builder /src/target/snitch_cluster/sw/runtime /opt/snitch_cluster/target/snitch_cluster/sw/runtime
COPY --from=builder /repo/target/snitch_cluster/sw/runtime /opt/snitch_cluster/target/snitch_cluster/sw/runtime

# === Optimized Package Installation ===
# Split apt commands into logical, cacheable layers.
# 1. Install prerequisites for adding new repositories.
RUN apt-get -y update && apt-get -y install --no-install-recommends \
      ca-certificates \
      wget \
      gnupg \
      lsb-release \
      software-properties-common

# 2. Add PPAs and Keys. This layer will be cached if the sources don't change.
RUN wget -O /etc/apt/keyrings/llvm-snapshot.gpg.key https://apt.llvm.org/llvm-snapshot.gpg.key \
   && echo "deb [signed-by=/etc/apt/keyrings/llvm-snapshot.gpg.key] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main" >> /etc/apt/sources.list \
   && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
   && add-apt-repository -y ppa:git-core/ppa

# 3. Update package lists and install final packages.
#    This is the layer that will most likely change.
#    Using --no-install-recommends reduces bloat.
RUN apt-get -y update \
   && apt-get -y install --no-install-recommends \
      # python runtime dependencies
      zlib1g \
      libncurses5 \
      libgdbm6 \
      libnss3 \
      libssl3 \
      libreadline8 \
      libffi7 \
      libsqlite3-0 \
      bzip2 \
      build-essential \
      # mlir
      mlir-16-tools \
      # misc
      make \
      git \
   # 4. Clean up in the SAME RUN command to reduce final image size.
   && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# Make our own python3.11 available for the current $USER
#ENV PATH="/opt/python3.11/bin:${PATH}"

COPY docker/entrypoint.sh /entrypoint.sh
# Ensure the entrypoint is executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
