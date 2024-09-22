# Use the official OpenJDK image as the base image for the backend
FROM openjdk:11-jre-slim AS backend

# Set the working directory
WORKDIR /app

# Copy the Spring Boot jar file to the container
COPY target/*.jar app.jar

# Expose the backend application port
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Use a multi-stage build for the frontend
FROM node:14 AS frontend

# Set working directory for frontend
WORKDIR /src/main

# Copy package.json and package-lock.json to install dependencies
COPY package.json ./
COPY package-lock.json ./

# Install dependencies with correct permissions
RUN npm install --unsafe-perm

# Ensure react-scripts has the right permissions
#RUN chmod -R 755 /src/main/node_modules/react-scripts

# Install frontend dependencies
RUN npm install

# Copy frontend files from src/main directory
COPY src/main ./src/main
COPY src/main/public ./public

# Build the frontend application
RUN npm run build

# Final stage to serve the application
FROM nginx:alpine

# Copy the built frontend files to the NGINX server's static directory
COPY --from=build /src/main/build /usr/share/nginx/html

# Expose the port NGINX will run on
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]