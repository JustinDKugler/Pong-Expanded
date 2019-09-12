Menu menu = new Menu(); // Object that stores information about the main menu
Game game = new Game();
Paddle[] paddle;
Pucks[] puck;

PFont SVBasicManual; // Create global font object
PImage arrowUp, arrowDown;
String gameState = "menu"; // Start the game on the menu screen, can be: "menu" "ingame" "gameover"

void setup() {
  background(0);
  frameRate(100);
  fullScreen(P2D);
  //size(960, 540, P2D);

  arrowUp = loadImage("../../assets/img/Arrow_Up.png"); // Selection arrows for the menu
  arrowDown = loadImage("../../assets/img/Arrow_Down.png"); 
  SVBasicManual = createFont("../../assets/font/SVBasicManual.ttf", 255); // Load font from directory, second parameter is the max size of font
}

void draw() {
  switch(gameState) { // What is displayed depends on the gameState
  case "ingame":
    background(0);
    game.tick();
    for (int i = 0; i < menu.paddleCount; i++) {
      paddle[i].display();
    }
    for (int i = 0; i < menu.puckCount; i++) {
      puck[i].display();
    }
    textAlign(LEFT, TOP);
    textSize(0.06 * height);
    text("Score: " + game.score, 0.1 * width, 0.1 * height);
    break;
  case "menu":
    background(0);
    menu.display();
    break;
  case "gameover":
    background(0);
    game.gameOver();
    break;
  default:
    println("ERROR: invalid gameState: " + gameState);
    break;
  }
}

void mouseClicked() {
  if (gameState == "menu") { // What the mouse buttons do when on the menu
    menu.buttonMaps(mouseX, mouseY);
  }
}

void keyPressed() {
  if (gameState == "ingame") { // Keys binds for while ingame
    switch(key) {
    case 'a':
    case 'A':
      game.moveLeft = true;
      break;
    case 'd':
    case 'D':
      game.moveRight = true;    
      break;
    case 'w':
    case 'W':
      game.moveUp = true;
      break;
    case 's':
    case 'S':
      game.moveDown = true;    
      break;
    default:
      break;
    }
  } else if (gameState == "menu") { // Menu binds
    switch(key) {
    case ' ': // Spacebar starts the game
      game.loadGame();
      break;
    default:
      break;
    }
  } else if (gameState == "gameover") { // Menu binds
    switch(key) {
    case ' ': // Spacebar restarts the game
      game.restart();
      gameState = "menu";
      break;
    default:
      break;
    }
  }
}

void keyReleased() {
  if (gameState == "ingame") { // Keys binds for while ingame
    switch(key) {
    case 'a':
    case 'A':
      game.moveLeft = false;
      break;
    case 'd':
    case 'D':
      game.moveRight = false;    
      break;
    case 'w':
    case 'W':
      game.moveUp = false;
      break;
    case 's':
    case 'S':
      game.moveDown = false;    
      break;
    default:
      break;
    }
  } else if (gameState == "menu") { // Menu binds
  }
}
