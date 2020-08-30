#https://codefresh.io/docs/docs/learn-by-example/java/spring-boot-2/
# Start with a base image containing Java runtime
#https://docs.docker.com/develop/develop-images/multistage-build/
#https://4sysops.com/archives/introduction-to-docker-bind-mounts-and-volumes/
FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN

WORKDIR '/mvn'

COPY pom.xml .

COPY settings-docker.xml .

RUN mvn -B dependency:go-offline -f ./pom.xml -s ./settings-docker.xml

COPY src /mvn/src

RUN mvn -B -s ./settings-docker.xml package

FROM openjdk:8-jdk-alpine

WORKDIR '/app'

# Add Maintainer Info
MAINTAINER Manish Pundir <mapundir7@gmail.com>

# Add a volume pointing to /tmp
#VOLUME /app/tmp

# Make port 8080 available to the world outside this container
EXPOSE 8080


# The application's jar file
#ARG JAR_FILE=target/websocket-demo-0.0.1-SNAPSHOT.jar

# Add the application's jar to the container
#ADD ${JAR_FILE} /appl/web-talk.jar

COPY --from=MAVEN_TOOL_CHAIN mvn/target/*.jar ./app.jar

COPY --from=MAVEN_TOOL_CHAIN /usr/share/maven/ref/repository usr/share/repos


# Run the jar file 
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"]

