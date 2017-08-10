FROM node:8.2-alpine

ENV NODE_ENV production

# Add git 
RUN apk add --no-cache --virtual git

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# Install NPM app dependencies
COPY package.json .
RUN npm install

# Bundle app source
COPY . /usr/src/app

# Install BOWER dependencies
RUN echo '{ "allow_root": true }' > /root/.bowerrc
COPY .bowerrc .
COPY bower.json .
RUN npm install bower@latest -g
RUN bower install

EXPOSE 3000
CMD [ "npm", "start" ]
