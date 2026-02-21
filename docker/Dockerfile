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

RUN git config --global url."https://github".insteadOf "git://github" \
   && git config --global url."https://github.com/".insteadOf "git@github.com:" \
   && git clone --recursive https://github.com/pulp-platform/snitch_cluster /repo \
   && cd /repo \
   && git reset --hard ${SNITCH_COMMIT} \
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

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=builder /repo/target/snitch_cluster/bin/snitch_cluster_bin.vlt /opt/snitch-rtl/bin/snitch_cluster.vlt
COPY --from=builder /opt/snitch-spike /opt/snitch-spike
COPY --from=builder /tools/riscv-llvm /opt/snitch-llvm

COPY --from=builder /repo/sw /opt/snitch_cluster/sw
COPY --from=builder /repo/target/snitch_cluster/sw/runtime /opt/snitch_cluster/target/snitch_cluster/sw/runtime

COPY --from=builder /repo/pyproject.toml /opt/snitch_cluster/
COPY --from=builder /repo/util /opt/snitch_cluster/util
COPY --from=builder /repo/nonfree/util /opt/snitch_cluster/nonfree/util
COPY --from=builder /repo/target/snitch_cluster/util /opt/snitch_cluster/target/snitch_cluster/util

RUN apt-get -y update && apt-get -y install --no-install-recommends \
      ca-certificates \
      wget \
      gnupg \
      lsb-release \
      software-properties-common

RUN wget -O /etc/apt/keyrings/llvm-snapshot.gpg.key https://apt.llvm.org/llvm-snapshot.gpg.key \
   && echo "deb [signed-by=/etc/apt/keyrings/llvm-snapshot.gpg.key] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main" >> /etc/apt/sources.list \
   && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
   && add-apt-repository -y ppa:git-core/ppa

RUN apt-get -y update \
   && apt-get -y install --no-install-recommends \
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
      mlir-16-tools \
      make \
      git \
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
