FROM adoptopenjdk/openjdk11

WORKDIR /app

EXPOSE 8081

COPY /target/cubegenweb.war /app

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "cubegenweb.war" ]
