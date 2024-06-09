FROM ubuntu:latest AS build

RUN apt-get update \
    && apt-get install -y openjdk-22-jdk maven \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN mvn clean install

FROM openjdk:22-jdk-slim

EXPOSE 8080

WORKDIR /app

COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar appcurriculo.jar

ENTRYPOINT ["java", "-jar", "appcurriculo.jar"]


