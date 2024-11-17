FROM maven:3.9-sapmachine-23 AS builder

WORKDIR /app
COPY . .

RUN mvn clean package

FROM openjdk:17-alpine

WORKDIR /app
COPY --from=builder app/target/*.jar app.jar

CMD ["java", "-jar", "/app.jar"]
