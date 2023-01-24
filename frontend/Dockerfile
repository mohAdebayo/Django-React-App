FROM node:13.12.0-alpine as build

WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . /app
RUN npm run build 

FROM nginx:stable-alpine
#EXPOSE 3000
COPY --from=build /app/build /usr/share/nginx/html
COPY --from=build /app /usr/share/nginx/html
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
#CMD ["nginx", "-g", "daemon off;"]
