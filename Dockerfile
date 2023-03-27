FROM adoptopenjdk/openjdk11

WORKDIR /app

EXPOSE 80

COPY /webapps/stella.war /app

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "stella.war" ]
