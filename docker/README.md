# Build instructions

Dependencies are defined in the repo root `pyproject.toml` and baked into the image at build time. When you run the container with the repo mounted at `/src`, the entrypoint runs `uv sync` from `/src`, so any changes to `pyproject.toml` (e.g. a different xdsl version) are applied on each container start.

## Build command

From the repo root, run

```sh
docker build -t snitch-toolchain -f docker/Dockerfile .
```

On Arm (emulate amd64):

```sh
docker build --platform linux/amd64 -t snitch-toolchain -f docker/Dockerfile .
```
