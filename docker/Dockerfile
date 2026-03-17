#-------------------------------------------------------------------------------
# Version pins — all version-sensitive values live here.
#
# The base image provides Verilator, Bender, and the Snitch-patched LLVM
# toolchain. We use its LLVM for both building and in the final image.
#
# Commit 7f430f2 uses the env var LLVM_BINROOT (renamed to SN_LLVM_BINROOT
# on main after this commit). If you bump the commit, check
# util/container/Dockerfile in the new commit for the expected env-var name.
#
# Build:  make docker-build
# Run:    make docker-run
#-------------------------------------------------------------------------------
ARG SNITCH_COMMIT=7f430f2
# Digest of ghcr.io/pulp-platform/snitch_cluster:main as of 2025-09.
# Pinned because the registry has no semver tags, only branch names.
ARG SNITCH_BASE_IMAGE=ghcr.io/pulp-platform/snitch_cluster@sha256:ad2491d877e84803297962091ce3485821bb529e921079ec4547f4a26d14d92a

#-------------------------------------------------------------------------------
# Stage 1: Builder
# Clones the repository and builds verilator model, software, and spike.
#-------------------------------------------------------------------------------
FROM ${SNITCH_BASE_IMAGE} AS builder
ARG SNITCH_COMMIT

# The base image sets SN_LLVM_BINROOT, but commit 7f430f2 expects LLVM_BINROOT.
ENV LLVM_BINROOT="/tools/riscv-llvm/bin"

# Patch .gitmodules to replace SSH URLs with HTTPS
# Clone the snitch_cluster repository into /repo
# If the repo URL or commit hash doesn't change, this layer remains cached.
# Patch num_sequencer_instructions from 32 to 64 in the default config to
# support larger FREP bodies (e.g. FP0_ASM_BODY with 36 instructions).
RUN git config --global url."https://github".insteadOf "git://github" \
   && git config --global url."https://github.com/".insteadOf "git@github.com:" \
   && git clone --recursive https://github.com/pulp-platform/snitch_cluster /repo \
   && cd /repo \
   && git reset --hard ${SNITCH_COMMIT} \
   && sed -i 's/num_sequencer_instructions: 32/num_sequencer_instructions: 64/' target/snitch_cluster/cfg/default.json \
   && make -C target/snitch_cluster verilator \
   && make -C target/snitch_cluster DEBUG=ON sw \
   && cd /repo/target/snitch_cluster/work-vlt/riscv-isa-sim \
   && ./configure --prefix=/opt/snitch-spike \
   && make install

#-------------------------------------------------------------------------------
# Stage 2: Final Toolchain Image
# Lean image with only the artifacts and runtime dependencies needed to
# compile and simulate Snitch programs.
#-------------------------------------------------------------------------------
FROM ubuntu:22.04 AS toolchain

# Set this environment variable early.
ENV DEBIAN_FRONTEND=noninteractive

# Combine related COPY commands to reduce image layers.
# Copying parent directories is more efficient than many individual sub-directories.

COPY --from=builder /repo/target/snitch_cluster/bin/snitch_cluster_bin.vlt /opt/snitch-rtl/bin/snitch_cluster.vlt

COPY --from=builder /opt/snitch-spike /opt/snitch-spike
COPY --from=builder /tools/riscv-llvm /opt/snitch-llvm


# Copy the entire 'sw' directory at once instead of its individual sub-directories.
COPY --from=builder /repo/sw /opt/snitch_cluster/sw

# Copy the entire runtime directory at once.
COPY --from=builder /repo/target/snitch_cluster/sw/runtime /opt/snitch_cluster/target/snitch_cluster/sw/runtime

# Copy Snitch Python package files.
COPY --from=builder /repo/pyproject.toml /opt/snitch_cluster/
COPY --from=builder /repo/util /opt/snitch_cluster/util
COPY --from=builder /repo/nonfree/util /opt/snitch_cluster/nonfree/util
COPY --from=builder /repo/target/snitch_cluster/util /opt/snitch_cluster/target/snitch_cluster/util

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

COPY --from=ghcr.io/astral-sh/uv:0.10.4 /uv /uvx /bin/
RUN uv python install 3.11

# Tell uv to use /opt/venv for all project operations, so that both
# build-time sync and the entrypoint's runtime sync target the same env.
ENV UV_PROJECT_ENVIRONMENT=/opt/venv
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app
COPY pyproject.toml uv.lock ./
RUN uv venv /opt/venv -p 3.11 \
   && uv sync --locked --no-install-project \
   && uv pip install /opt/snitch_cluster

WORKDIR /src

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
