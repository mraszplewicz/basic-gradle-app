FROM openjdk:8-jdk-alpine
WORKDIR /app

#ENV GRADLE_OPTS -Dorg.gradle.daemon=false

COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle
RUN ./gradlew --version
# Download dependencies layer
RUN ./gradlew build 2>/dev/null || true

COPY . .
RUN ./gradlew build

RUN test -f build/classes/java/main/test/Test.class
