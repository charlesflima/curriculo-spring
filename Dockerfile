# Etapa de build
# Etapa de build
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests=true

# Etapa de runtime
FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "/app/appcurriculo.jar"]


