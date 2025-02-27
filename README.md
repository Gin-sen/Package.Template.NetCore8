# My.New.Solution

# Prise en compte de l'environnement

Le package de log et l'API devraient être configuré pour ne pas activer les APM et les logs au format ECS (json) en mode Development.

Env :
- Development                  Pas d'APM, pas de logs au format ECS 
- Docker                       APM et logs au format ECS pour des raison de developpement du package (TODO: voir si ca peut se régler a coup de directives de pre-processor (#if DEBUG))
- Inté, Recette, Autre, ...    APM + logs au format ECS 

# Mise en place du cluster ELK local

## Initialiser le cluster ELK 

Lancer profil ELK dans VS.

ou

Lancer la commande :

`docker compose up -d setup es01 kibana metricbeat01 filebeat01 logstash01 fleet-server`

## Activer les APM

### Methode automatique

yq est nécessaire pour l'exécution du script.

Executez le script `./init_apm_server.yaml` pour configurer le server APM.


### Methode manuelle

Aller sur https://localhost:5601 (elastic / changeme)
Aller sur la page Fleet > Settings > Output > Cliquer sur modifier

Lancer la commande : `docker cp $(docker ps -f 'name=es01' --format '{{.Names}}'):/usr/share/elasticsearch/config/certs/ca/ca.crt .`
Lancer la commande et copiez le resultat : `openssl x509 -fingerprint -sha256 -noout -in ca.crt | awk -F"=" {' print $2 '} | sed s/://g`
Lancer la commande et copiez le resultat : `cat ca.crt`

Dans l'interface de Kibana :
- modifier http://localhost:9200 en https://es01:9200
- coller le resultat de la commande openssl
- coller ce yaml dans la partie finale de la configuration et y ajouter le certificat (résultat de la commande cat) :

```yaml
ssl:
  certificate_authorities:
  - |
    -----BEGIN CER.....
    .......
    ......
```

- sauvegardez, vous pouvez maintenant utiliser les APM sur votre cluster local (url: http://fleet-server:8220, token: supersecrettoken).

## Ajouter une dataview pour les logs filebeat

### Methode automatique

Lancer le script `./init_filebeat_dataview.sh` pour créer la dataview pour les logs filebeat.

Il faudra appliquer des filtres pour avoir un résultat propre.


### Methode manuelle

Aller dans Discover, cliquer sur les dataviews en haut a gauche et sélectionner "créer une dataview".

Nommer la dataview `filebeat` et renseignez `filebeat*` dans le champ de pattern, sauvegarder.

## Utiliser le templating de dotnet

Pour installer cette solution en tant que template, lancer la commande dans le dossier racine du projet :

```bash
dotnet new install .
```

Pour créer un projet en utilisant cette template :

```bash
dotnet new my-logging-package -in=false -n My.New.Solution
```