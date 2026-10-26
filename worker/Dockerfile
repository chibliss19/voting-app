FROM mcr.microsoft.com/dotnet/sdk:7.0.410 AS build
WORKDIR /source
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c release -o /app --no-restore
FROM mcr.microsoft.com/dotnet/runtime:7.0.20
WORKDIR /app
COPY --from=build /app ./
RUN groupadd -r appuser && useradd -r -g appuser appuser && chown -R appuser:appuser /app
USER appuser
ENTRYPOINT ["dotnet", "Worker.dll"]
