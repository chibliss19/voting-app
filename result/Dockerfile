FROM node:18.20.4-slim
WORKDIR /usr/local/app
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force
COPY . .
RUN chown -R node:node /usr/local/app
USER node
ENV PORT=80
EXPOSE 80
CMD ["node", "server.js"]
