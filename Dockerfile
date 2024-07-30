FROM node:16-alpine

# Cria um usuário e grupo para rodar a aplicação
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Define o diretório de trabalho
WORKDIR /app

# Copia o package.json e o package-lock.json
COPY package*.json ./

# Instale todas as dependências, incluindo o novo plugin Babel
RUN npm install && npm install @babel/plugin-transform-private-property-in-object --save-dev

# Ajusta as permissões do diretório de trabalho
RUN mkdir -p /app/node_modules && chown -R appuser:appgroup /app

# Copia o restante do código da aplicação
COPY . .

# Ajusta as permissões da pasta de trabalho
RUN chown -R appuser:appgroup /app

# Muda para o novo usuário
USER appuser

# Exponha a porta
EXPOSE 3000

# Comando para rodar a aplicação
CMD ["npm", "start"]
