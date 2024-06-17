# `flywheel`

This Docker image, basically Debian, with extra ~~"trust from Microsoft" 🤣~~ speed and security. It meant to work within many crucial container runtime (docker, podman, containerd, ...) and a test unit will be written to make sure it happen.

By default flywheel includes:

- [mimalloc](https://github.com/microsoft/mimalloc)