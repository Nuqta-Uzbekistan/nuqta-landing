FROM node:20-alpine AS build

LABEL maintainer="Abduroziq <reply@blogchik.uz>"
LABEL version="1.0"
LABEL description="Nuqta jamoasining landing sahifasi Docker imagei"
LABEL company="Nuqta"

WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm install

COPY . .

RUN npm run build

FROM node:20-alpine AS production

WORKDIR /app

COPY --from=build /app/package.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public

EXPOSE 3000

CMD ["npm", "start"]
