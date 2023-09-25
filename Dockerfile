FROM node:18-alpine AS create-build

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

RUN npm ci

COPY --chown=node:node . .

EXPOSE 3000

RUN npm run build

ENV NODE_ENV production

FROM node:18-alpine AS run-build

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

RUN npm ci

COPY --chown=node:node . .

EXPOSE 3000

RUN npm run build
CMD ["npm", "run", "start:prod"]

ENV NODE_ENV production
