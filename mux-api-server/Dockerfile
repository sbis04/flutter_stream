# Import base image
FROM node:14.15.1-alpine3.12

# Set up a working dir for the app
WORKDIR /usr/src/app

ENV PORT 3000
ENV HOST 0.0.0.0

# Copy over the package json
COPY package.json .

# Install typescript and app deps
RUN npm install --only=production

# Add remaining app files
COPY . .

# Start app in prod
CMD [ "npm", "start" ]