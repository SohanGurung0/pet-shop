# -- Stage 1: Build ----------------------------------------------------------
# Downloads dependencies first (separate layer = cached on rebuild if pom.xml unchanged)
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and fetch dependencies first (layer cached unless pom.xml changes)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build the WAR
COPY src ./src
RUN mvn clean package -DskipTests -B

# -- Stage 2: Runtime --------------------------------------------------------
# Only the compiled WAR goes into the final image - no Maven, no source code
FROM tomcat:10.1-jdk17-temurin

# Remove default Tomcat sample apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy WAR as ROOT so app is served at / not /pet-supply
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Render expects port 8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
