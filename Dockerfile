FROM adoptopenjdk/openjdk11

WORKDIR /app

EXPOSE 80

COPY lib/webapps/stella.war /app

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "stells.war" ]
