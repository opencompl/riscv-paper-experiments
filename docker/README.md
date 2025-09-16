# Build instructions

## Build command

In the parent directory directory, run

```sh
docker build -t snitch-toolchain -f docker/Dockerfile .
```

(On Arm)

```sh
docker build --platform linux/amd64 -t snitch-toolchain -f docker/Dockerfile .
```
