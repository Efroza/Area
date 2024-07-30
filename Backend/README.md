![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) ![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white) ![Django](https://img.shields.io/badge/django-%23092E20.svg?style=for-the-badge&logo=django&logoColor=white) ![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
# Serveur AREA
Le serveur d'AREA est fait en ![Python](https://www.python.org/) avec un framework en ![Django](https://www.djangoproject.com/), la database est en sql avec ![MariaDB](https://mariadb.org/).
## Lancer le projet
Réaliser les commandes suivantes :
```
  pip install python3
  pip install mysql
  pip install twilio
  python manage.py runserveur
 ```

## Lancer le projet avec Docker
Réaliser les commandes suivantes au root du repo:
```
  docker-compose up
 ```

## Lancer la documentation technique du serveur :
Réaliser les commandes suivantes :
```
  brew install doxygen
  doxygen
 ```
Puis ouvrir le fichier index.html dans le dossier doc/html