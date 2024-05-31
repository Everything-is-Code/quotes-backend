FROM registry.access.redhat.com/ubi8/openjdk-21 AS build

USER 1001

# RUN chown -R 1001:1001 /app
# RUN chmod -R 775 /app

RUN mkdir app

COPY src /app/src
COPY pom.xml /app

RUN cd /app && mvn -DskipTests=true clean package
RUN ls -ltra /app/target/
RUN cd /app/target/ && ls && pwd

FROM registry.access.redhat.com/ubi8/openjdk-21
ENV LANGUAGE='en_US:en'
WORKDIR /deployments/

USER 1001

# We make four distinct layers so if there are application changes the library layers can be re-used
COPY  --from=build --chown=185 /app/target/quarkus-app/lib/ /deployments/lib/
COPY  --from=build --chown=185 /app/target/quarkus-app/*.jar /deployments/
COPY  --from=build --chown=185 /app/target/quarkus-app/app/ /deployments/app/
COPY  --from=build --chown=185 /app/target/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080

ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"

ENTRYPOINT [ "/opt/jboss/container/java/run/run-java.sh" ]
 
