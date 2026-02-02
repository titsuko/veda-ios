FROM gradle:8.5-jdk21 AS builder
WORKDIR /app

COPY settings.gradle.kts build.gradle.kts ./

COPY app/build.gradle.kts app/
COPY common/build.gradle.kts common/

COPY feature/ feature/

RUN ./gradlew dependencies --no-daemon || return 0

COPY . .

RUN ./gradlew :app:build -x test --no-daemon

FROM eclipse-temurin:21-jre-jammy AS production
WORKDIR /app

RUN useradd -m -s /bin/bash appuser
USER appuser

COPY --from=builder /app/app/build/libs/*.jar app.jar

ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -Djava.security.egd=file:/dev/./urandom"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]