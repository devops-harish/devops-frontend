FROM node:alpine as build-deps
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build
RUN rm -rf /usr/src/app/node_modules

FROM build-deps as base
WORKDIR /usr/src/app
COPY --from=build-deps /usr/src/app/build ./build
EXPOSE 80
CMD ["sh", "-c", "npx serve -s build -p 80 -l tcp://$REACT_APP_BACKEND_URL"]
