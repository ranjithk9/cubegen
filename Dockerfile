FROM adoptopenjdk/openjdk11

WORKDIR /app

EXPOSE 80

COPY target/my-web-app.jar /app

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "my-web-app.jar" ]
