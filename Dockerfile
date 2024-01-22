FROM eclipse-temurin:latest
RUN mkdir /app
COPY target/submission-elsan-1.0-SNAPSHOT.jar /app/submission-elsan-1.0-SNAPSHOT.jar
CMD ["java", "-jar", "/app/submission-elsan-1.0-SNAPSHOT.jar"]
