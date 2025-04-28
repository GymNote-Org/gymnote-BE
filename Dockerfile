FROM bellsoft/liberica-openjdk-alpine:17 AS builder

WORKDIR /app

COPY . .

RUN ./gradlew clean build

FROM bellsoft/liberica-openjdk-alpine:17

WORKDIR /app

COPY --from=builder /app/build/libs/gymnote-1.0.0.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "${JAVA_OPTS}", "-jar", "app.jar"]