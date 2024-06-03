FROM registry.access.redhat.com/ubi8/openjdk-21 AS build

USER 185

# WORKDIR /app

# RUN chown -R 1001:1001 /app
# RUN chmod -R 775 /app

COPY src .
COPY pom.xml .

RUN mvn clean install -DskipTests
# RUN ls -ltra /app/target/
# RUN cd /app/target/ && ls && pwd


# We make four distinct layers so if there are application changes the library layers can be re-used

RUN mkdir /deployments
COPY  --chown=185 /home/jboss/target/quarkus-app/lib/ /deployments/lib/
COPY  --chown=185 /home/jboss/target/quarkus-app/*.jar /deployments/
COPY  --chown=185 /home/jboss/target/quarkus-app/app/ /deployments/app/
COPY  --chown=185 /home/jboss/target/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080

ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"

ENTRYPOINT [ "/opt/jboss/container/java/run/run-java.sh" ]
