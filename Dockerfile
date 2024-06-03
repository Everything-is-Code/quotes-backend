FROM registry.access.redhat.com/ubi8/openjdk-21 AS build

# WORKDIR /app
COPY src .
COPY pom.xml .

RUN ./mvnw clean package -Pnative -Dquarkus.kubernetes.deploy=true
# RUN ls -ltra /app/target/
# RUN cd /app/target/ && ls && pwd


# We make four distinct layers so if there are application changes the library layers can be re-used
COPY  --chown=185 /home/jboss/target/quarkus-app/lib/ /deployments/lib/
COPY  --chown=185 /home/jboss/target/quarkus-app/*.jar /deployments/
COPY  --chown=185 /home/jboss/target/quarkus-app/app/ /deployments/app/
COPY  --chown=185 /home/jboss/target/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080
USER 185
ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"

ENTRYPOINT [ "/opt/jboss/container/java/run/run-java.sh" ]
