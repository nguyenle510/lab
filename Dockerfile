FROM openjdk:17
WORKDIR /app
COPY /home/jenkins/workspace/test/target/demoapp.jar /app/
EXPOSE 8080
CMD ["java", "-jar","demoapp.jar"]
