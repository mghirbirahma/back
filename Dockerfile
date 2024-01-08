
 FROM maven:3.8.4openjdk:17 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

FROM adoptopenjdk:11-jre-hotspot

# cp target/spring-boot-web.jar /opt/app/app.jar
COPY --from=builder /app/*.jar /app/app.jar

Expose 8080

CMD["java", "-jar","app.jar"]
