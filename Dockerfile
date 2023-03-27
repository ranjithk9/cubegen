FROM adoptopenjdk/openjdk11

WORKDIR /app

EXPOSE 80

COPY target/cubegen-web-app.war /app

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "cubegen-web-app.war" ]
