# Etapa de build
FROM maven:4.0.0-openjdk-22-slim AS build
COPY . .
RUN ./mvnw clean package -DskipTests=true

# Etapa de runtime
FROM openjdk:22-jdk-slim
EXPOSE 8080
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "/app/appcurriculo.jar"]

