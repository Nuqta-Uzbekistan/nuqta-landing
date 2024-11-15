FROM node:16 AS build

LABEL maintainer="Abduroziq <reply@blogchik.uz>"
LABEL version="1.0"
LABEL description="Nuqta jamoasning landing sahifasi imagei"
LABEL company="Nuqta"

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]