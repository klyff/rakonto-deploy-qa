FROM node:16-alpine as ui
WORKDIR /app
COPY rakonto-ui/build ./build
#COPY rakonto-ui .
#RUN yarn install && yarn build

FROM openjdk:14-jdk-slim as backend
WORKDIR /app
COPY rakonto-backend .
RUN mkdir -p src/main/resources/public
COPY --from=ui /app/build src/main/resources/public
RUN ./gradlew build

FROM openjdk:14-jdk-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg imagemagick
COPY --from=backend /app/build/libs/*.jar ./app.jar
EXPOSE 8080
ENV ENV=${ENV}
CMD [ "sh", "-c", "java -jar -Dspring.profiles.active=${ENV} app.jar" ]
