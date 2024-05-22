# Use the official ASP.NET Core runtime as a parent image
FROM mcr.microsoft.com/dotnet/sdk:3.1.426 AS base
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs
RUN npm install eslint babel-eslint eslint-plugin-import eslint-config-react-app
RUN dotnet restore "./reacttemp.csproj" --disable-parallel
RUN dotnet publish "reacttemp.csproj" -c release -o /app/publish

FROM mcr.microsoft.com/dotnet/sdk:3.1.426
WORKDIR /app
COPY --from=base /app/publish ./
EXPOSE 8002
ENTRYPOINT ["dotnet", "reacttemp.dll"]