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
# Digest of ghcr.io/pulp-platform/snitch_cluster:main for commit ecf876f.
# Pinned because the registry has no semver tags, only branch names.
ARG SNITCH_BASE_IMAGE=ghcr.io/pulp-platform/snitch_cluster-sw@sha256:f4e4ebfe0a984b8d8d64afa878551da8c09740a2e1b05b200694efdcb428ce46

FROM ${SNITCH_BASE_IMAGE} AS snitch

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

COPY --from=snitch /tools/bin/snitch_cluster.vlt /opt/snitch_cluster.vlt
COPY --from=builder /tools/riscv-llvm /opt/snitch-llvm

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
   && uv sync --locked --no-install-project

WORKDIR /src

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
