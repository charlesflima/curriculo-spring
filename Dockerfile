# Etapa de build
# Use a imagem do Maven com OpenJDK 22 como base para compilar e empacotar a aplicação
FROM maven:3.8.7-openjdk-22-slim AS build

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo pom.xml e o Maven Wrapper para o contêiner
COPY pom.xml ./
COPY mvnw ./
COPY .mvn ./.mvn

# Baixa as dependências do Maven
RUN ./mvnw dependency:go-offline

# Copia o código fonte do projeto para o contêiner
COPY src ./src

# Compila e empacota o projeto
RUN ./mvnw clean package

# Use a imagem do OpenJDK 22 como base para o contêiner final
FROM adoptopenjdk:22-jre-hotspot

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo JAR gerado para o contêiner final
COPY --from=build /app/target/appcurriculo-0.0.1-SNAPSHOT.jar /app/appcurriculo.jar

# Expõe a porta 8080, que é a porta padrão para aplicativos Spring Boot
EXPOSE 8080

# Comando para executar a aplicação quando o contêiner for iniciado
CMD ["java", "-jar", "appcurriculo.jar"]







