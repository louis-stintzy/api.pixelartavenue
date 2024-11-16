# Base stage
FROM node:18 AS base
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Development stage
FROM base AS dev
RUN npm install -g nodemon
EXPOSE 3101
CMD ["npm", "run", "dev"]

# Build stage
FROM base AS build
RUN npm run build

# Production stage
FROM node:18-slim AS prod
LABEL app="Pixel Art Avenue (API)"
RUN addgroup -g 1598 pixelartgroup && adduser -D -u 1599 -G pixelartgroup pixelartuser
USER pixelartuser
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
EXPOSE 3101
CMD ["node", "dist/index.js"]