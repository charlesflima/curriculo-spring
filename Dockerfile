# Etapa de construção
FROM openjdk:22-jdk-slim AS build

# Instalar Maven
RUN apt-get update && apt-get install -y maven

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto para o contêiner
COPY . .

# Dar permissão de execução para o Maven Wrapper
RUN chmod +x mvnw

# Executar o Maven para compilar o projeto e criar o arquivo JAR, ignorando os testes
RUN ./mvnw clean package -DskipTests=true

# Etapa de execução
FROM openjdk:22-jdk-slim

# Expor a porta que a aplicação irá rodar
EXPOSE 8080

# Copiar o arquivo JAR construído da etapa de build
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar

# Definir o ponto de entrada do contêiner para executar a aplicação
ENTRYPOINT ["java", "-jar", "/app/appcurriculo.jar"]








