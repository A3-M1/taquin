# Taquin game 

This app shows exercises to create and play a final taquin game. You can play the game if you click on the button in the right bottom corner.

For the game, the picture is coming from a [website](https://picsum.photos/300/300) that generates random pictures, your gallery or your phone (you can choose where come from your pic on the setting of the app)

To play the taquin, you can click on one of the square or slide with your finger on Taquin to move the square. 

 If you click on the setting button &#9881; on the left bottom of the taquin, you can see a pop-up with different settings for the game :
 - Slider size of the taquin : change the size from 2 to 10
 - Difficulty level of the game : easy, medium, difficulty
 - Where come from the pic 
 - Display the number on the squares 

If you click on the reload button &#128260; on the center bottom of the taquin, you can reload the taquin game. 

If you click on the go back button ↩ [](#) on the left bottom of the taquin, you can come back from a move you did and the counter, on the top of the taquin, will substract the number from one occurency.

&#8594; On your phone, if you turn your phone in the landscape mode, the screen will be stuck.


## Install and use the project

Start by clonning the repo on your computer
```sh
git clone https://github.com/A3-M1/taquin
```

Then install all the necessary dependencies
```sh
flutter pub get
```

You can finally run the project on Chrome
```sh
flutter run -d Chrome 
```

Or on your Android phone*
```sh
flutter run -d "phone_name"
```

If you have a problem with the app, you can copy and paste the code above 
```sh
flutter clear
```
Then reinstall the dependencies and re-run the app

*If you want to put the app on your phone, you have to activate the developer mode (click seven times on the build number in your setting) and in the developer setting, activate the debug mode. After you can see your phone name if you copy and paste the code above on a terminal

```sh
flutter devices
```

## Roadmap 

This is a list of improvements you can make on the app:

- - A timer at the top to show how long you have been solving the game

- Add a pop-up to notify if you win the game

- On the setting, add a button to put or remove the number on the square 

- Click on a square next to the square you want to move to move all the raw







