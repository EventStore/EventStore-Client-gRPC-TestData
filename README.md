# Event Store gRPC Client Integration Test Container

This repository contains a known data set and Dockerfile to build a test container against which integration tests for Event Store gRPC-based clients can run.

The container is built automatically based on the version specified in the `Dockerfile`, and pushed to the GitHub Package Repository.

## Usage

The data set is located in `/var/lib/eventstore` in the image. Consequently, the same image can be used to provision either a new, blank, ephemeral database, or to start with the known data set.

For example, the following Docker Compose file is used for `EventStore-Client-Java` to start with the known data set:

```yaml
version: '3'

services:
  eventstore:
    image: ghcr.io/eventstore/testdata:ci
    ports:
      - 1113:1113/tcp
      - 1114:1114/tcp
      - 2113:2113/tcp
      - 2114:2114/tcp
    healthcheck:
      interval: 1s
      timeout: 1s
      retries: 10 
    volumes:
    - ./src/test/resources/server1.pfx:/opt/eventstore/certs/server1.pfx
    environment:
      EVENTSTORE_DB: /data/integration-tests
      EVENTSTORE_CERTIFICATE_FILE: /opt/eventstore/certs/server1.pfx
      EVENTSTORE_CERTIFICATE_PASSWORD: changeit
```

## Rebuilding

The Event Store Server image from which this test image is constructed has a source version specified in the `Dockerfile`, which should be modified when a new build is needed. To publish with GitHub actions, [run the action manually](https://github.com/EventStore/EventStore-Client-gRPC-TestData/actions/workflows/build.yml) and specify the base tag, e.g., `ci` or `21.10.0-buster-slim`.