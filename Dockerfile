FROM maven:3.9-sapmachine-23 AS builder

COPY . .

RUN mvn clean package

FROM openjdk:17-alpine

COPY --from=builder /target/*.jar app.jar

CMD ["java", "-jar", "/app.jar"]
