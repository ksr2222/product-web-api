FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

COPY ..

RUN chmod +x gradlew

RUN ./gradlew clean build -x test

FROM eclipse-temurin:21-jdk
WORKDIR /app

COPY --from-build /app/build/libs/*.jar app.jar

EXPOSE 8000

ENTRYPOINT ["java", "-jar", "app.jar"]