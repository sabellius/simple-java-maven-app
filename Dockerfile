FROM maven:3.9-sapmachine-23 AS builder

COPY . .

# Set up Git configuration (use the GitHub token as a secret)
ARG REPO_PAT
# ENV GITHUB_TOKEN=$GITHUB_TOKEN

RUN git config --global user.name "github-actions[bot]" && git config --global user.email "github-actions[bot]@users.noreply.github.com"

RUN git remote set-url origin https://$REPO_PAT@github.com/sabellius/simple-java-maven-app.git

RUN git add pom.xml VERSION.txt && git commit -m "Automated commit from Dockerfile" && git push origin master

RUN mvn clean package

FROM openjdk:17-alpine

COPY --from=builder /target/*.jar app.jar

CMD ["java", "-jar", "/app.jar"]
