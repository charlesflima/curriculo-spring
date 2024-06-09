FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y openjdk-22-jdk maven

COPY . .

RUN ./mvnw clean package -DskipTests=true

FROM openjdk:22-jdk-slim
EXPOSE 8080
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "/app/appcurriculo.jar"]






