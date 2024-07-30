![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white) ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Android Studio](https://img.shields.io/badge/Android%20Studio-3DDC84.svg?style=for-the-badge&logo=android-studio&logoColor=white) ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
# Application mobile AREA

L'application mobile AREA est faites en Flutter, testé sur [Android Studio](https://developer.android.com/studio), On utilise aussi [Firebase](https://firebase.google.com/) en plus de notre propre database afin de pouvoir connecté les comptes google.

## Lancer le projet

Réaliser la commande suivante :
```
docker build -t area .
```
Ou alors, ouvrir un émulateur tel que Android Studio et lancer l'application dessus :

Configuration recommandé sur android studio :

![android](https://user-images.githubusercontent.com/72019436/200117975-2ee6d2e0-4e16-4b9a-b1cc-6cf097903921.png)

Lancer l'émulateur sur visual studio code :
  
  * Appuyez sur ce bouton dans la barre d'outils : ![image](https://user-images.githubusercontent.com/72019436/200118424-c69ca742-285b-4ff2-aa52-2311091e1ec2.png)
  * Ensuite choisissez l'émulateur que vous voulez utiliser :

![start-android](https://user-images.githubusercontent.com/72019436/200117917-8f732979-a7c3-4eb0-b3b6-a443f26366d3.jpg)

Ensuite rendez-vous dans le fichier [main.dart](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/blob/master/Flutter/lib/main.dart) et lancer l'application en appuyant sur Run :

![launch_flutter](https://user-images.githubusercontent.com/72019436/200118250-12cb8c2a-6511-4d4a-8d82-9504ffe860b1.jpg)

Si tout s'est bien passé, voici ce que vous devriez voir :

![image](https://user-images.githubusercontent.com/72019436/200118299-a9b78fd5-6dad-4e60-9769-3acdf465b7c9.png)

N'oubliez pas de lancer le [serveur](https://github.com/EpitechPromo2025/B-DEV-500-PAR-5-1-area-yosra.hassan/tree/master/Backend) afin de pouvoir utiliser l'application.

## Documentation technique

Si vous souhaitez obtenir la documentation technique du code, il suffit de faire :
```
  dart doc
```
Cette commande va génerer un dossier doc :

![doc_folder](https://user-images.githubusercontent.com/72019436/200118637-d7205988-8bb4-4583-b10c-a1f6f6b03f8b.jpg)


Dans ce dossier se trouve un fichier index.html avec toute la documentation pour chaque fichier:

![index_html](https://user-images.githubusercontent.com/72019436/200118674-aa0a3230-a755-490e-85e4-d5df1462de31.jpg)


