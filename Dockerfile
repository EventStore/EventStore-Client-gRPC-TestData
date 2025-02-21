ARG source_version=25.0.0-rc.1-x64-8.0-jammy

FROM docker.eventstore.com/eventstore-preview/kurrentdb:$source_version
USER root
RUN mkdir /data && \
    chown kurrent:kurrent /data 
USER kurrent
RUN ln -s /var/lib/kurrentdb /data/integration-tests
COPY --chown=kurrent:kurrent dataset20MB/* /var/lib/kurrentdb/
