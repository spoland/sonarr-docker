FROM debian:bookworm-slim AS builder
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget tar ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /usr/share/locale

RUN wget --content-disposition 'https://services.sonarr.tv/v1/download/main/latest?version=4&os=linux&arch=x64' && \
    tar -xvzf Sonarr*.linux*.tar.gz -C /tmp/ && \
    mv /tmp/Sonarr /tmp/sonarr_extracted && \
    rm Sonarr*.linux*.tar.gz

# Stage 2: final
FROM mcr.microsoft.com/dotnet/runtime:9.0-bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -m sonarr && \
    mkdir -p /config && \
    chown sonarr:sonarr /config && \
    apt-get update && \
    apt-get install -y --no-install-recommends libsqlite3-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /usr/share/locale

COPY --from=builder --chown=sonarr:sonarr /tmp/sonarr_extracted /opt/Sonarr

COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

USER sonarr
WORKDIR /opt/Sonarr
ENTRYPOINT ["/opt/Sonarr/Sonarr", "-nobrowser", "-data=/config/"]
EXPOSE 8989