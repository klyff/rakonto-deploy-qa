FROM node as ui
WORKDIR /app
COPY rakonto-ui .
RUN yarn install && yarn build

FROM openjdk:14-jdk-alpine as backend
WORKDIR /app
COPY rakonto-backend .
RUN mkdir -p src/main/resources/public
COPY --from=ui /app/build src/main/resources/public
RUN ./gradlew build

FROM openjdk:14-jdk-alpine
COPY --from=backend /app/build/libs/*.jar ./app.jar
EXPOSE 8080
ENV ENV=qa
CMD [ "sh", "-c", "java -jar -Dspring.profiles.active=qa app.jar" ]