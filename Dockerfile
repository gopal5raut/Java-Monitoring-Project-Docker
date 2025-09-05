# Build Stage
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

COPY . .

RUN apk update && apk add maven

RUN mvn package -DskipTests

# Runtime Stage
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

CMD [ "java", "-jar", "app.jar" ]
