# Stage 1: Build the Node.js application
FROM node:alpine as build-deps
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the built application with Nginx
FROM nginx:alpine
RUN mkdir /usr/share/nginx/buffer
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN mkdir /usr/share/nginx/log
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
