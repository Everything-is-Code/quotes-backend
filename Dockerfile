FROM registry.access.redhat.com/ubi8/openjdk-21 AS build

ENV LANGUAGE='en_US:en'

WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work

COPY . .
RUN mvn clean install -DskipTests

RUN ls -la /home/jboss/target/quarkus-app/lib
# We make four distinct layers so if there are application changes the library layers can be re-used
COPY --chown=185 /home/jboss/target/quarkus-app/lib/ /deployments/lib/
COPY --chown=185 /home/jboss/target/quarkus-app/*.jar /deployments/
COPY --chown=185 /home/jboss/target/quarkus-app/app/ /deployments/app/
COPY --chown=185 /home/jboss/target/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080
USER 185
ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"

ENTRYPOINT [ "/opt/jboss/container/java/run/run-java.sh" ]
