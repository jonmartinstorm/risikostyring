# ---------- Build stage ----------
FROM eclipse-temurin:25-jdk AS build
WORKDIR /app

# Copy gradle wrapper + config first for caching
COPY gradlew gradlew
COPY gradle/ gradle/
COPY build.gradle.kts settings.gradle.kts gradle.properties ./
RUN chmod +x gradlew

# Warm cache (won't fail the build if task list differs)
RUN ./gradlew --no-daemon -q tasks >/dev/null 2>&1 || true

# Copy sources last (breaks cache when code changes)
COPY src/ src/

# Build
RUN ./gradlew --no-daemon clean build -x test

# ---------- Runtime stage ----------
FROM eclipse-temurin:25-jre
WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/app.jar

EXPOSE 4001
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
