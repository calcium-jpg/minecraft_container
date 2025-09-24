FROM alpine:latest

ARG MINECRAFT_VERSION="1.21.8"
ARG JAVA_VERSION="21"

EXPOSE 25565/tcp

RUN apk add --no-cache openjdk${JAVA_VERSION}-jre jq curl

RUN adduser -D user
RUN mkdir /data
RUN chown user /data

WORKDIR /data

COPY --chown=user --chmod=755 build/run.sh ./
COPY build/eula.txt ./
RUN ./run.sh -u $MINECRAFT_VERSION

VOLUME ["/data"]

USER user

ENTRYPOINT ["./run.sh"]
