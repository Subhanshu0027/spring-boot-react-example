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

# Set the working directory for the frontend
WORKDIR /frontend

# Copy package.json and package-lock.json
COPY frontend/package*.json ./

# Install dependencies with correct permissions
RUN npm install --unsafe-perm

# Ensure react-scripts has the right permissions
RUN chmod -R 755 /frontend/node_modules/react-scripts

# Install frontend dependencies
RUN npm install

# Copy the frontend source code
COPY frontend/ ./

# Build the frontend application
RUN npm run build

# Final stage to serve the application
FROM nginx:alpine

# Copy the built frontend files from the previous stage
COPY --from=frontend /frontend/build /usr/share/nginx/html

# Copy the nginx configuration file (if you have one)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for the frontend
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]