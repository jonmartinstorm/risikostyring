# ---------- Build stage ----------
FROM eclipse-temurin:25-jdk AS build
WORKDIR /app

COPY gradlew gradlew
COPY gradle/ gradle/
COPY build.gradle.kts settings.gradle.kts gradle.properties ./
RUN chmod +x gradlew

# Optional cache warmup
RUN ./gradlew --no-daemon dependencies || true

COPY src/ src/
RUN ./gradlew --no-daemon clean build -x test

# ---------- Runtime stage ----------
FROM eclipse-temurin:25-jre
WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/app.jar

EXPOSE 4001
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
