FROM ghcr.io/pulp-platform/snitch_cluster-sw@sha256:290416751224ccb0a5bf5a583dbad6bc60c985f8fd4a2577775a4af43f2abf6a AS toolchain
ARG VIRTUAL_ENV="/root/.venvs/snitch_cluster"
ARG PYTHON_VERSION=3.11

# Patch .gitmodules to replace SSH URLs with HTTPS
# Clone the snitch_cluster repository into /repo
# If the repo URL or commit hash doesn't change, this layer remains cached.
RUN git config --global url."https://github".insteadOf "git://github" \
   && git config --global url."https://github.com/".insteadOf "git@github.com:" \
   && git clone --recursive https://github.com/pulp-platform/snitch_cluster /opt/snitch_cluster \
   && cd /opt/snitch_cluster \
   && git reset --hard 742fbe3259125fc182fba11f756fd0af4d87404f \
   && make DEBUG=ON sn-runtime -j

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
RUN apt-add-repository ppa:deadsnakes/ppa \
   && apt-get -y update \
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
      python${PYTHON_VERSION}-dev \
   # 4. Clean up in the SAME RUN command to reduce final image size.
   && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

COPY requirements.txt ./requirements.txt
COPY xdsl ./xdsl
RUN . ${VIRTUAL_ENV}/bin/activate && pip install -r ./requirements.txt
