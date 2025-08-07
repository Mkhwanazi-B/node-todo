FROM node:20-alpine AS base 
WORKDIR /app

FROM base AS build
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

FROM base AS runtime
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app .
EXPOSE 8080
CMD ["node", "sever.js"]
