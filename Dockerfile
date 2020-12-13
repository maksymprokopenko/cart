# dev part
FROM node:12.13-alpine AS dev
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# prod part
FROM node:12.13-alpine AS prod
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY --from=dev /app/dist ./dist
CMD ["node", "dist/main"]
