# Taquin

This app show exercices to create a final taquin game. 

It use a json in the [asset folder](/assets/) corresponding to an API request made on the [APOD API from NASA](https://api.nasa.gov/).
```
https://api.nasa.gov/planetary/apod?start_date=2024-01-01&end_date=2024-02-20&api_key=API_KEY
```

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





