FROM tomcat:8.2.20-jre8

WORKDIR /app

EXPOSE 8081

COPY /target/cubegenweb-app*.war /usr/local/tomcat/cubugenweb-app.war

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "cubegenweb.war" ]
