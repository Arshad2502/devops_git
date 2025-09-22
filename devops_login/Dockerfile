# -------------------------
# Step 1: Build WAR with Maven
# -------------------------
FROM maven:3.9.4-eclipse-temurin-8 AS builder

# Set working directory
WORKDIR /app

# Copy Maven config and source code
COPY pom.xml .
COPY src ./src

# Download dependencies first (helps with network issues in CI)
RUN mvn dependency:go-offline

# Build WAR (skip tests)
RUN mvn clean package -DskipTests

# -------------------------
# Step 2: Deploy WAR to Tomcat
# -------------------------
FROM tomcat:9.0.79-jdk8

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from builder stage
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
