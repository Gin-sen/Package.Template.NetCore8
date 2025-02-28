# My.New.Solution

Template .Net Core 8 pour la création de package.
TODO : Github actions

# Lancement des implémentations d'exemple du package

Lancer la commande :

`docker compose up -d`

## Utiliser le templating de dotnet

Pour installer cette solution en tant que template, lancer la commande dans le dossier racine du projet :

```bash
dotnet new install .
```

Pour créer un projet en utilisant cette template :

```bash
dotnet new my-package -in=false -n My.Brand.New.Solution
```