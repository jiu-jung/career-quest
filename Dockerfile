# Build stage
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app

# 1) Wrapper/gradle 설정 파일을 먼저 복사 (캐시 효율)
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle settings.gradle ./
# (있으면) COPY gradle.properties ./
RUN chmod +x gradlew

# 2) 의존성 프리다운로드 (옵션이지만 CI에서 매우 유리)
RUN ./gradlew --no-daemon dependencies || true

# 3) 소스 복사 후 빌드
COPY . .
RUN ./gradlew build -x test --no-daemon

# Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]