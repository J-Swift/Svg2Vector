################################################################################
# Build container
################################################################################

FROM gradle:jdk8 AS BUILDER

WORKDIR /home/gradle

COPY src src
COPY build.gradle .

RUN gradle build --quiet --no-daemon
RUN mv build/libs/gradle.jar application.jar


################################################################################
# Run container
################################################################################

FROM amazoncorretto:8

WORKDIR /opt/target
VOLUME /mounts/input /mounts/output

COPY --from=BUILDER /home/gradle/application.jar .

CMD ["java", "-jar", "application.jar"]
