ARG source_version=6.0.0-preview1.0.1905-buster-slim

FROM docker.pkg.github.com/eventstore/eventstore/eventstore:$source_version
USER root
RUN mkdir -p /data/integration-tests
COPY dataset20MB/* /data/integration-tests/
RUN chown -R eventstore:eventstore /data/integration-tests
USER eventstore
