FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
#copy project to app folder
COPY *.csproj ./
#restore nuget dependencies
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=build-env /app/publish .
ENTRYPOINT ["dotnet", "pipelines_dotnet_core.dll"]


