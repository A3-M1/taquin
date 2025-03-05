# Taquin

This app show exercices to create a final taquin game and you can play the final if you click on the button in the right bottom corner.

For the game, the picture is coming from a website [website](https://picsum.photos/300/300) that generate random pictures

If you slide for the bottom, you can see a pop-up with different settings for the game :
 - Slider size of the taquin
 - Level of difficulty
 - Where come from the pic
 - Display the number on the squares

## Install and use the project

Start by clonning the repo on your computer
```sh
git clone https://github.com/A3-M1/taquin
```

Then navigate to the project directory
```sh
cd ./apoc/
```

Then install all the necessary dependencies
```sh
flutter pub get
```

You can finally run the project
```sh
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

*Note that we used the flag `--web-browser-flag "--disable-web-security"` so that we are not annoyed by the CORS policies of the NASA API. If you don't use it, the images may not load correctly.*

## Roadmap 

- Rond qui tourne pour reload le jeu 

- temps pour réssoudre le taquin + comteur de déplacement des tuiles en haut

- théorie du taquin mode simple, moyen, expert 

- pop up pour dire au joueur qu'il a gagné 

- faire en sorte que les numéros sur les tuiles dépendant de l'image

- appuyer sur une tuile plus loin pour faire bouger toute une partie de la ligne 

- autorisé les taquins 2 par 2

- bouton d'aide pour aider le joueur : activé et désactivé les numéros 





