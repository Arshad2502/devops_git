# Step 1: Build the WAR using Maven
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy Maven files
COPY pom.xml devops_login/
COPY src devops_login/

# Build the WAR file
RUN mvn clean package -DskipTests

# Step 2: Deploy WAR to Tomcat
FROM tomcat:10.1.15-jdk17

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from the builder stage
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
