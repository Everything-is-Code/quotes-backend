FROM registry.access.redhat.com/ubi8/openjdk-21

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'

WORKDIR /app

USER 1001

COPY . ./

RUN ./mvnw package

EXPOSE 8080

ENTRYPOINT [ "java -jar /app/target/quote-app-1.0.0-SNAPSHOT.jar" ]