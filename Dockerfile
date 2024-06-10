# Etapa de build

FROM alpine AS build

# Instalação do JDK 22 e do Maven
RUN apk update && apk add openjdk22 maven

WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests=true

# Etapa de runtime
FROM hetzer7/alpine
EXPOSE 8080
WORKDIR /app
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar
ENTRYPOINT ["java", "-jar", "/app/appcurriculo.jar"]

