class Game {

  Boolean moveLeft = false, moveRight = false, moveUp = false, moveDown = false;
  int score = 0, highScore = 0, cumulativeScore = 0; // Counts number of paddle bounces, saves highest, tracks lifetime score

  void loadGame() { // Loads the count and creates paddle/puck objects, changes gameState
    paddle = new Paddle[menu.paddleCount + menu.wallCount];
    puck = new Pucks[menu.puckCount];
    switch (menu.levelList[menu.level]) {
    case "easy": // 3 walls, 2 paddles, 2 pucks
      for (int i = 0; i < menu.puckCount; i++) {
        puck[i] = new Pucks(i);
      }
      paddle[0] = new Paddle(1);
      paddle[1] = new Paddle(2);
      paddle[2] = new Paddle(3);
      paddle[3] = new Paddle(true, false, 19, 1);
      paddle[4] = new Paddle(true, false, 19, 3);
      break;
    case "medium":
      for (int i = 0; i < menu.puckCount; i++) {
        puck[i] = new Pucks(i);
      }
      paddle[0] = new Paddle(1);
      paddle[1] = new Paddle(2);
      paddle[2] = new Paddle(false, true, 1, 2);
      paddle[3] = new Paddle(false, true, 1, 6);
      paddle[4] = new Paddle(true, false, 19, 2);
      paddle[5] = new Paddle(true, false, 19, 6);
      break;    
    case "hard":
      for (int i = 0; i < menu.puckCount; i++) {
        puck[i] = new Pucks(i);
      }
      paddle[0] = new Paddle(false, true, 1, 1);
      paddle[1] = new Paddle(false, true, 1, 5);
      paddle[2] = new Paddle(false, true, 19, 3);
      paddle[3] = new Paddle(false, true, 19, 7);
      paddle[4] = new Paddle(true, false, 1, 1);
      paddle[5] = new Paddle(true, false, 1, 5);
      paddle[6] = new Paddle(true, false, 19, 3);
      paddle[7] = new Paddle(true, false, 19, 7);
      break;
    case "corridor":
      for (int i = 0; i < menu.puckCount; i++) {
        puck[i] = new Pucks(i);
      }
      paddle[0] = new Paddle(2);
      paddle[1] = new Paddle(4);
      paddle[2] = new Paddle(5);
      paddle[3] = new Paddle(6);
      paddle[4] = new Paddle(false, true, 19.3, 4);
      paddle[5] = new Paddle(false, true, 0.5, 4);
      break;
    case "custom": // Best coding practices are not observed in this section as creating a level editor is the only good way of doing it
      for (int i = 0; i < menu.puckCount; i++) {
        puck[i] = new Pucks(i);
      }
      menu.paddleCount += menu.wallCount;
      println("paddleCount: " + menu.paddleCount + " wallCount: " + menu.wallCount);
      for (int i = 0; i < menu.wallCount; i++) {
        paddle[i] = new Paddle(i + 1);
        println("Paddle " + i + " is a wall");
      }
      menu.paddleCount -= menu.wallCount;
      if (menu.paddleCount > 0) {
        paddle[0 + menu.wallCount] = new Paddle(true, true, 0.5, 0.5);
        println("Paddle " + 0 + menu.wallCount);
      }
      if (menu.paddleCount > 1) {
        paddle[1 + menu.wallCount] = new Paddle(true, false, 1, 2);
      }
      if (menu.paddleCount > 2) {
        paddle[2 + menu.wallCount] = new Paddle(false, true, 18, 6);
        println("Paddle " + 2 + menu.wallCount);
      }      
      if (menu.paddleCount > 3) {
        paddle[3 + menu.wallCount] = new Paddle(true, false, 18, 6);
      }
      if (menu.paddleCount > 4) {
        paddle[4 + menu.wallCount] = new Paddle(false, true, 1, 2);
        println("Paddle " + 4 + menu.wallCount);
      }
      if (menu.paddleCount > 5) {
        paddle[5 + menu.wallCount] = new Paddle(true, true, 0.5, 18);
      }
      if (menu.paddleCount > 6) {
        paddle[6 + menu.wallCount] = new Paddle(true, false, 1, 6);
        println("Paddle " + 6 + menu.wallCount);
      }
      if (menu.paddleCount > 7) {
        paddle[7 + menu.wallCount] = new Paddle(false, true, 18, 2);
      }
      if (menu.paddleCount > 8) {
        paddle[8 + menu.wallCount] = new Paddle(true, false, 18, 2);
        println("Paddle " + 8 + menu.wallCount);
      }
      if (menu.paddleCount > 9) {
        paddle[9 + menu.wallCount] = new Paddle(false, true, 1, 6);
      }
      if (menu.paddleCount > 10) {
        paddle[10 + menu.wallCount] = new Paddle(true, true, 18, 18);
        println("Paddle " + 10 + menu.wallCount);
      }
      if (menu.paddleCount > 11) {
        paddle[11 + menu.wallCount] = new Paddle(true, false, 1, 4);
      }
      if (menu.paddleCount > 12) {
        paddle[12 + menu.wallCount] = new Paddle(false, true, 18, 0);
        println("Paddle " + 12 + menu.wallCount);
      }
      if (menu.paddleCount > 13) {
        paddle[13 + menu.wallCount] = new Paddle(true, false, 18, 0);
      }
      if (menu.paddleCount > 14) {
        paddle[14 + menu.wallCount] = new Paddle(false, true, 1, 4);
        println("Paddle " + 14 + menu.wallCount);
      }
      if (menu.paddleCount > 15) {
        paddle[15 + menu.wallCount] = new Paddle(true, true, 18, 0.5);
        println("Paddle " + 15 + menu.wallCount);
      }
      menu.paddleCount += menu.wallCount;
      break;
    default:
      println("ERROR: Unknown difficulty");
      break;
    }
    gameState = "ingame"; // Begins game
  }

  void tick() {
    for (int i = 0; i < menu.paddleCount; i++) {
      paddle[i].move();
    }
    for (int i = 0; i < menu.puckCount; i++) {
      puck[i].move();
      if (puck[i].testForLoss()) {
        menu.paddleCount -= menu.wallCount;
        gameState = "gameover";
      }
    }
  }

  void gameOver() {
    fill(0, 255, 0);
    textFont(SVBasicManual);
    textAlign(CENTER, BOTTOM); // Strings are written right above the specified coords and are centered on them
    textSize(0.1 * height);
    text("Game Over", 0.5 * width, 0.3 * height);
    textSize(0.06 * height);
    text("You let a puck off screen!", 0.5 * width, 0.4 * height);
    textSize(0.06 * height);
    text("Your Score: " + game.score + ",  High Score: " + highScore, 0.5 * width, 0.5 * height);
    if (score > highScore) { // Animated high score
      textAlign(CENTER, CENTER);
      textSize(0.12 * height);
      /*rect(0.29 * width, 0.5 * height, 0.01 * width, 0.3 * height); // Decorative paddles not needed
      rect(0.69 * width, 0.5 * height, 0.01 * width, 0.3 * height);*/
      text("NEW HIGH SCORE", width * (0.5 + 0.01*sin(radians(frameCount/0.25))), 0.65 * height);
    }
    textAlign(CENTER, BOTTOM);
    textSize(0.06 * height);
    text("Press space to return to menu", 0.5 * width, 0.9 * height);
  }

  void restart() {
    if (score > highScore) {
      highScore = score;
    }
    cumulativeScore += score;
    score = 0;
    game.moveLeft = false;
    game.moveRight = false;
    game.moveUp = false;
    game.moveDown = false;
  }
}
