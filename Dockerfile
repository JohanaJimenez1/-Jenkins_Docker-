FROM node:14-alpine

WORKDIR /usr/src/app


COPY package*.json ./
RUN npm install -g npm@7 && npm install


COPY . .


EXPOSE 3000


CMD ["npm", "start"]


