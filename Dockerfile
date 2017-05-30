FROM openjdk:8u131-jdk
ARG jg_version
ENV JG_VERSION ${jg_version}
LABEL version ${JG_VERSION}
LABEL description "JanusGraph v${JG_VERSION}"
LABEL maintainer "Marc Carre <carre.marc@gmail.com>"

COPY signatures/KEYS .
COPY signatures/janusgraph-${JG_VERSION}-hadoop2.zip.asc .
RUN curl -fsSLO https://github.com/JanusGraph/janusgraph/releases/download/v${JG_VERSION}/janusgraph-${JG_VERSION}-hadoop2.zip && \
  gpg --import KEYS && \
  rm -f KEYS && \
  gpg --verify janusgraph-${JG_VERSION}-hadoop2.zip.asc && \
  rm -f janusgraph-${JG_VERSION}-hadoop2.zip.asc && \
  unzip janusgraph-${JG_VERSION}-hadoop2.zip && \
  rm janusgraph-${JG_VERSION}-hadoop2.zip

WORKDIR janusgraph-${JG_VERSION}-hadoop2
ENTRYPOINT ["bin/gremlin.sh"]
