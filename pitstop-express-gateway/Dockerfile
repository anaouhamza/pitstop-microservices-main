FROM node:lts-alpine
# Définir le répertoire de travail dans le conteneur
WORKDIR /usr/src/app
# Copier les fichiers de configuration des dépendances
COPY package*.json ./
# Installer les dépendances
RUN npm install
# Copier le reste de l'application dans le conteneur
COPY . .
# Exposer le port sur lequel l'application écoute
EXPOSE 8080
# Démarrer l'application
CMD ["node", "server.js"]
