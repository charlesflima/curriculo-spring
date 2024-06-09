FROM openjdk:22-jdk-slim AS build

WORKDIR /app
COPY . .

# Garanta que o script mvnw tenha permissão de execução
RUN chmod +x mvnw

RUN ./mvnw clean package

FROM openjdk:22-jdk-slim
EXPOSE 8080
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "/app/appcurriculo.jar"]




