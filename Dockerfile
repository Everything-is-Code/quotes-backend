FROM registry.access.redhat.com/ubi8/openjdk-21

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'

WORKDIR /app

USER 1001

RUN chown 1001:1001 .
RUN chmod -R 775 .

COPY . ./

RUN mvn package

EXPOSE 8080

ENTRYPOINT ["java -jar /app/target/quarkus-app/quarkus-run.jar"]