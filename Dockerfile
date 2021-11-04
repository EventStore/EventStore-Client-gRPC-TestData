ARG source_version=21.10.0-buster-slim

FROM ghcr.io/eventstore/eventstore:$source_version
USER root
RUN mkdir /data && \
    chown eventstore:eventstore /data 
USER eventstore
RUN ln -s /var/lib/eventstore /data/integration-tests
COPY --chown=eventstore:eventstore dataset20MB/* /var/lib/eventstore/
