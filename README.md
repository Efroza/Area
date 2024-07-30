![](https://img.shields.io/badge/App-Made%20with%20Flutter-blue) ![](https://img.shields.io/badge/Web-Made%20with%20React-9cf) ![](https://img.shields.io/badge/Serveur-Made%20with%20Python-yellow) ![](https://img.shields.io/badge/Project-Made%20with%20Love-ff69b4)
# Projet Area
Cette documentation est aussi disponible en format Doxygen au [root](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/) du repository en réalisant la commande :
```
doxygen POC
```
## Introduction
Area est un projet réalisée en 3ème année à Epitech Paris à réalisé en 2 mois.
Ce projet à pour but de refaire une application/site web type [IFTTT](https://ifttt.com/explore) .

En résumé le but du projet est d'avoir une application qui va pouvoir créer des chaînes d'instructions, avec des actions et des réactions.
C'est à dire pouvoir faire des actions automatisées comme par exemple au lancement d'un live Twitch, l'application va automatiquement tweeter "Live twitch maintenant !" sur votre compte twitter.

Ce projet est réalisé sur 3 langages différents libre et nous avons choisi :

Front-End application mobile : [Flutter](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/tree/master/Flutter)

Front-End site web : [React](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/tree/master/web-front)

Back-End serveur : [Python](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/tree/master/Backend)

## Lancer le projet
Vous pouvez lancer le projet depuis le [root](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/) du repository avec la commande :
```
docker-compose up --build
```

Vous pouvez aussi lancer chaque partie individuellement, chaque partie possède sa propre documentation avec les différentes commandes.
  1. [Application mobile](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/tree/master/Flutter)
  2. [Application web](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/tree/master/web-front)
  3. [Serveur](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/tree/master/Backend)

## Choix des langages
### Site web : [React Js](https://fr.reactjs.org/)
Afin de réaliser notre site web, nous nous sommes penchés sur le React Js qui est une bibliothèque JavaScript.
React JS est une bibliothèque JavaScript utilisée dans le développement Web pour créer des éléments interactifs sur des sites Web.
Pour autant nous aurions pu choisir un autre language comme le Ruby ou encore le PHP.
Nous avons préféré partir sur le React Js car pour nous c'est un langage qui nous sera utile très vite dans notre carrière mais aussi parce que nous le connaissions déjà un peu.
En effet, une membre de notre groupe connaissait déjà cette technologie ainsi que des bases en HTML et CSS ce qui était un net plus, ça permettait d'enlever un peu de charge de travail et donc de nous faire gagner du temps. Et en plus c'est une technologie qui est encore beaucoup utilisé aujourd'hui, grandement recherché à l'embauche, plus que d'autre comme le Ruby par exemple.

Le but étant de recréer un IFTT à la perfection, nous ne pouvions laisser les choses au hasard et avons voulu jouer la sureté pour le développement du site web.

### Application mobile : [Flutter](https://flutter.dev/)
Pour ce qui est de notre application mobile, nous avons abandonné la sureté est sommes partis sur un langages inconnus pour chacun d'entre nous : Flutter.
Flutter est un framework de développement d’applications mobiles open source de Google.
Nous aurions pu coder en C ou en C++ qu'on connait tous très bien grâce à Epitech, mais c'est plus utilisé pour faire des jeux ce qui n'est pas notre but aussi et nous voulions saisir cette opportunités pour découvrir quelque chose de nouveau. On s'est alors penchés sur Flutter, tout d'abord parce que c'est une application multiplateformes, qui marche donc sur différents systèmes d'exploitation (Android, Google). Mais aussi par sa fluidité avec son système de rechargement à chaud grâce à laquelle il est possible de voir toutes nos modifications en temps réel. Flutter est un langage open-source, c'est à dire qu'il y aura pendant encore longtemps une communauté toujours prête à s'entraider.

Ce choix est aussi comme pour le React un choix d'avenir, car qui dit multiplatforme veut dire réduction des coûts et donc utilisés de plus en plus par les entreprises. C'est donc une bonne compétence à inclure sur son cv.

### Serveur : [Python](https://www.python.org/)
Au niveau du backend nous avions en premier lieu choisi comme langage du node.js mais après discussion avec mûr réflexion notre choix finale c’est porté sur du Python.

Python est l'un des langages polyvalents les plus puissants et le plus utilisés pour le développement Web, ainsi que pour l'analyse de données. C'est le langage le plus proche de l’homme, soit il est extrêmement facile à apprendre et à utiliser et également facile à développer.
Ici encore nous avions le choix que ce soit JavaScript, Ruby ou encore PHP. Nous ne voulions pas refaire du JavaScript (React), donc encore une fois nous nous sommes portés vers un choix de sureté comme c'est un langage que nous avons tous déjà utilisé au moins une fois.
Cependant même si nous le connaissons, aucun d'entre nous ne l'avait utilisé pour le développement web alors que celui-ci est considéré comme l'un des meilleurs langages dans cette catégorie et il est largement utilisé encore aujourd'hui. C'est un langage qui offre de nombreuses fonctionnalités grâce aux différentes librairies qu'il propose. Ainsi selon nous un des meilleurs langages côté serveur pour le développement Web.

Python est à la foix un choix de sécurité car nous le connaissons tous, mais aussi un choix d'avenir car c'est une compétence qui est depuis longtemps une valeur incontournable à avoir. Mais aussi et surtout un choix personnel, comment ne pas apprécier coder en python.

## Structure du projet.
Ce projet est structuré de sorte à ce que tout passe par le serveur, aucune donnée n'est stocker sur les fronts, ils ne font que appeler le serveur qui leur donne ses informations.
Une image vaut des milliers de mots : ![Post ](https://user-images.githubusercontent.com/72019436/201544745-e79ba7b9-9d04-4bab-b56b-7c60d577a9eb.png)


## Auteurs
  * Yosra Hassan alias [@yosracandy](https://github.com/yosracandy)
  * Royale Badiabo alias [@broyale](https://github.com/broyale)
  * Yohan Henry alias [@yoyokaseur](https://github.com/yoyokaseur)
  * Brice Boualavong alias [@efroza](https://github.com/Efroza)
  * Luc Schmitt alias [@lucsc](https://github.com/Lucsc)
