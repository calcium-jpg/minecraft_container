ARG JAVA_VERSION="21"

FROM eclipse-temurin:${JAVA_VERSION}-jre

EXPOSE 25565/tcp

RUN useradd user
RUN mkdir /data
RUN chown user /data

VOLUME ["/data"]
WORKDIR /data

COPY server.jar ./
COPY eula.txt ./

USER user

ENTRYPOINT ["/opt/java/openjdk/bin/java"]
CMD ["-XX:MaxRAMPercentage=15.0", "-jar", "server.jar", "--nogui"]
