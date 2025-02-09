FROM openjdk:17
WORKDIR /app
COPY /target/demoapp.jar /app/
EXPOSE 8080
CMD ["java", "-jar","demoapp.jar"]
