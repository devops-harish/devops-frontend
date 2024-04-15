FROM node:alpine as build-deps
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN rm -rf /usr/src/app/node_modules
EXPOSE 80
CMD ["npm", "start"]