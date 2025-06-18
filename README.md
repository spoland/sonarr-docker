# Sonarr Docker

A simple Docker setup for running [Sonarr](https://sonarr.tv/), an internet PVR for Usenet and Torrents.

## Project Structure

```
sonarr-docker/
├── Dockerfile
├── .dockerignore
└── README.md
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your system.

## Building the Docker Image

1. Clone or download this repository and navigate to the project directory:

   ```bash
   cd sonarr-docker
   ```

2. Build the Docker image:

   ```bash
   docker build -t sonarr-docker .
   ```

## Running the Docker Container

To start a Sonarr container:

```bash
docker run -d \
  --name prowlarr \
  -p 8989:8989 \
  sonarr-docker
```

The web UI will be available at: [http://localhost:8989](http://localhost:8989).

If you're running Docker on a remote server, replace localhost with the IP address of your Docker host machine.

### Optional: Persisting Data

To persist Sonarr data, mount a local directory as a volume:

```bash
docker run -d \
  --name sonarr \
  -p 8989:8989 \
  -v /path/to/sonarr/library:/library \
  sonarr-docker
```

Replace `/path/to/sonarr/library` with your preferred local directory.

## Updating

To update Sonarr, rebuild the image and recreate the container.

## License

This project is provided as-is and is not affiliated with the Sonarr project.
