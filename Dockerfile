FROM ubuntu:lastest AS build

RUN apt-get update
RUN apt-get install openjdk-22-jdk -y
COPY . .


RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:22-jdk-slim
EXPOSE 8080
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "appcurriculo.jar"]


