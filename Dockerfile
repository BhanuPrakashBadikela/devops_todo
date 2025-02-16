

# Build Stage

FROM node:16 AS build



# Set working directory

WORKDIR /app



# Install dependencies

COPY package*.json ./

RUN npm install



# Copy app files

COPY . .



# Build the app (if applicable)

RUN npm install -g typescript



# Production Stage

FROM node:16-slim



# Set working directory for production

WORKDIR /app



# Copy the necessary files from the build stage

COPY --from=build /app /app

RUN npm ci --only=production



# Expose port 3000

EXPOSE 3333



# Start the app

CMD ["npm", "start"]


