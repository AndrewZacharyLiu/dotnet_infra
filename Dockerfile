# Use the official ASP.NET Core runtime as a parent image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /app
COPY . .

RUN dotnet restore "./ECommerce.Api.csproj" --disable-parallel
RUN dotnet publish "ECommerce.Api.csproj" -c release -o /app/publish

FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /app
COPY --from=base /app/publish ./
ENV DOTNET_URLS=http://+:8002
ENTRYPOINT ["dotnet", "ECommerce.Api.dll"]