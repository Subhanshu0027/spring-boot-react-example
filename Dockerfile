FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the .csproj file and restore the dependencies
COPY aspnet-core-dotnet-core/*.csproj ./
RUN dotnet restore

# Copy the rest of the application files
COPY aspnet-core-dotnet-core/. ./

# Build the application
RUN dotnet publish -c Release -o out

# Use the official .NET Core runtime image for the final stage
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime

# Set the working directory in the runtime container
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /app/out ./

# Expose the port the app runs on
EXPOSE 80

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "aspnet-core-dotnet-core.dll"]
