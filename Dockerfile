# Etapa de build
FROM adoptopenjdk:22-jdk-hotspot AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests=true

# Etapa de runtime
FROM adoptopenjdk:22-jre-hotspot
EXPOSE 8080
WORKDIR /app
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "/app/appcurriculo.jar"]


