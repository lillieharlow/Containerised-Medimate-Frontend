# syntax=docker/dockerfile:1

FROM node:20-alpine AS base
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

# ---------- DEV ----------
FROM base AS dev
ENV NODE_ENV=development
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

# ---------- TEST ----------
FROM base AS test
ENV NODE_ENV=test
CMD ["npm", "test"]

# ---------- BUILD ----------
FROM base AS build
ENV NODE_ENV=production
RUN npm run build

# ---------- PRODUCTION ----------
FROM nginx:alpine AS production
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80