FROM --platform=linux/amd64 maven:3.8.5-openjdk-17 as build
# speed up Maven JVM a bit
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"
# set working directory
WORKDIR /opt/expenseTrackerService
# copy just pom.xml
COPY pom.xml .
# go-offline using the pom.xml
RUN mvn dependency:go-offline
# copy your other files
COPY ./src ./src
# compile the source code and package it in a jar file
RUN mvn clean install -Dmaven.test.skip=true

FROM --platform=linux/amd64 openjdk:17-alpine
# set deployment directory
WORKDIR /home/root/app
# copy over the built artifact from the maven image
COPY --from=build /opt/expenseTrackerService/target/expenseTrackerService-0.0.1-SNAPSHOT.jar /home/root/app
ENTRYPOINT ["java","-jar","expenseTrackerService-0.0.1-SNAPSHOT.jar"]
