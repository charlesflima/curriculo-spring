# Etapa de build
FROM maven:3.8.7-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests=true

# Etapa de runtime
FROM openjdk:8-jre
EXPOSE 8080
WORKDIR /app
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "/app/appcurriculo.jar"]









