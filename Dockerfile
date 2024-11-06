FROM maven:3.9.9 as build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/demoapp.jar /app/
EXPOSE 8080
CMD ["java", "-jar","demoapp.jar"]
