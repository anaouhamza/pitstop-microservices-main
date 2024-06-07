FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Définir la variable d'environnement avant de lancer le build
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN npm run build

# Étape finale pour servir l'application
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
