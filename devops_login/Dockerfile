# Use Maven with JDK 17
FROM maven:3.9.4-eclipse-temurin-17

# Set working directory
WORKDIR /app

# Copy the project files
COPY pom.xml .
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# The WAR will be available at /app/target/*.war
