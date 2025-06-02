FROM node:20-alpine

# Créer un utilisateur non-root pour la sécurité
RUN addgroup -g 1001 -S nodejs
RUN adduser -S backend -u 1001

# Définir le répertoire de travail
WORKDIR /usr/src/app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances de production uniquement
RUN npm ci --omit=dev && npm cache clean --force

# Copier le code source
COPY . .

# Changer le propriétaire des fichiers vers l'utilisateur nodejs
RUN chown -R backend:nodejs /usr/src/app
USER backend

# Variables d'environnement
ENV NODE_ENV=production
ENV PORT=3000

# Exposer le port
EXPOSE $PORT

# Commande par défaut pour démarrer l'application
CMD ["npm", "start"]
