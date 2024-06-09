# Etapa de build
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests=true

# Etapa de runtime
FROM adoptopenjdk:17-jre-hotspot
EXPOSE 8080
WORKDIR /app
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "appcurriculo.jar"]





