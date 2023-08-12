# Fetching the latest node image on alpine linux
FROM node:16 AS builder

# Declaring env
ENV NODE_ENV production

# Setting up the work directory
WORKDIR /react-app

# Installing dependencies
COPY ./src src
COPY ./public public
COPY package.json package.json
# COPY package-lock.json package-lock.json

RUN npm install 

RUN npm run build

RUN npm prune
# Starting our application
# Fetching the latest nginx image
FROM nginx

# Copying built assets from builder
COPY --from=builder /react-app/build /usr/share/nginx/html

# Copying our nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf