FROM registry.access.redhat.com/ubi8/openjdk-21

# WORKDIR /app
COPY . .

RUN mvn clean install -DskipTests
# RUN ls -ltra /app/target/
# RUN cd /app/target/ && ls && pwd


EXPOSE 8080
USER 185
ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/home/jboss/target/quarkus-app/quarkus-run.jar"

ENTRYPOINT [ "/opt/jboss/container/java/run/run-java.sh" ]
