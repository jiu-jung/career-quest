# Build stage
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app

COPY gradlew /app/gradlew
COPY gradle/ /app/gradle/
COPY build.gradle settings.gradle /app/
RUN chmod +x /app/gradlew

RUN /app/gradlew --no-daemon dependencies || true

COPY . /app/
RUN /app/gradlew build -x test --no-daemon

# Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]