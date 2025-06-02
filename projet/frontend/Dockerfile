# Dockerfile pour le frontend React/Vite

# --- Build Stage ---
FROM node:20-alpine AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances (npm ci pour une installation plus rapide et reproductible)
RUN npm ci

# Copier le code source
COPY . .

# Variables d'environnement pour le build
ENV REACT_APP_TEXT="Production build from Docker"
ENV NODE_ENV=production

# Builder l'application (génère le dossier dist/)
RUN npm run build

# --- Production Stage ---
FROM nginx:1.25-alpine

# Copier les fichiers buildés depuis l'étape précédente
COPY --from=builder /app/dist /usr/share/nginx/html

# Copier une configuration Nginx personnalisée (optionnel)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port 80
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
