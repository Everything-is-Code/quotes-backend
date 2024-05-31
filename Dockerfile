FROM registry.access.redhat.com/ubi8/openjdk-21 AS build

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'

COPY --chown=185 . ./
RUN ./mvnw package
# We make four distinct layers so if there are application changes the library layers can be re-used
COPY  --from=build --chown=185 /home/jboss/target/quarkus-app/lib/ /deployments/lib/
COPY  --from=build --chown=185 /home/jboss/target/quarkus-app/*.jar /deployments/
COPY  --from=build --chown=185 /home/jboss/target/quarkus-app/app/ /deployments/app/
COPY  --from=build --chown=185 /home/jboss/target/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080
USER 185
ENV AB_JOLOKIA_OFF=""
ENV JAVA_OPTS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"