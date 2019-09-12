class Menu {

  String[] levelList = {"easy", "medium", "hard", "corridor", "custom"};
  int level = 0; // Starts on easy
  int paddleCount, puckCount, wallCount; // Physics object amounts

  void display() {
    // Update counts based on difficulty, make sure to update hard coded levels from gameLoad()
    switch (menu.levelList[menu.level]) {
    case "easy":
      menu.paddleCount = 5;
      menu.puckCount = 2;
      menu.wallCount = 0;
      break;
    case "medium":
      menu.paddleCount = 6;
      menu.puckCount = 3;
      menu.wallCount = 0;
      break;
    case "hard":
      menu.paddleCount = 8;
      menu.puckCount = 2;
      menu.wallCount = 0;
      break;
    case "corridor":
      menu.paddleCount = 6;
      menu.puckCount = 2;
      menu.wallCount = 0;
      break;
    default:
      break;
    }

    // Set text
    fill(0, 255, 0);
    stroke(0, 255, 0);
    textFont(SVBasicManual);

    // Animated title
    textAlign(CENTER, CENTER); // Strings are written right below the specified coords and are centered on them
    textSize(0.1 * height);
    rect(0.30 * width, 0.05 * height, 0.02 * width, 0.2 * height);
    rect(0.68 * width, 0.05 * height, 0.02 * width, 0.2 * height);
    text("Pong", width * (0.5 + 0.12*sin(radians(frameCount/4))), 0.15 * height);

    line(0.3 * width, 0.3 * height, 0.7 * width, 0.3 * height);

    // Menu body
    textAlign(LEFT, TOP);
    textSize(0.06 * height);

    text("Paddle Controls: WASD", 0.3 * width, 0.32 * height);

    text("Level: " + levelList[level], 0.35 * width, 0.4 * height);
    image(arrowUp, 0.3 * width, 0.4 * height, 0.04 * width, 0.025 * height);
    image(arrowDown, 0.3 * width, 0.425 * height, 0.04 * width, 0.025 * height);

    text("Paddles: " + paddleCount, 0.4 * width, 0.45 * height);
    text("Pucks: " + puckCount, 0.4 * width, 0.5 * height);
    if (levelList[level] == "custom") {
      image(arrowUp, 0.35 * width, 0.45 * height, 0.04 * width, 0.025 * height);
      image(arrowDown, 0.35 * width, 0.475 * height, 0.04 * width, 0.025 * height);    
      image(arrowUp, 0.35 * width, 0.5 * height, 0.04 * width, 0.025 * height);
      image(arrowDown, 0.35 * width, 0.525 * height, 0.04 * width, 0.025 * height);
      text("Walls: " + wallCount, 0.4 * width, 0.55 * height);
      image(arrowUp, 0.35 * width, 0.55 * height, 0.04 * width, 0.025 * height);
      image(arrowDown, 0.35 * width, 0.575 * height, 0.04 * width, 0.025 * height);
    }
    text("High Score: " + game.highScore, 0.3 * width, 0.67 * height);
    text("Cumulative Score: " + game.cumulativeScore, 0.3 * width, 0.72 * height);
    
    line(0.3 * width, 0.8 * height, 0.7 * width, 0.8 * height);

    textAlign(CENTER, BOTTOM);
    text("Press space to start", 0.5 * width, 0.9 * height);
    
    textAlign(RIGHT, BOTTOM);
    textSize(0.015 * height);
    fill(100);
    text("By Justin Kugler and Joe Benson, 2019", 0.99 * width, 0.99 * height);
  }

  void buttonMaps(int x, int y) {
    if (x > 0.3 * width && x < 0.34 * width) {
      if (y > 0.4 * height && y < 0.425 * height) {
        // Difficulty up arrow clicked
        level = (level + 1) % (levelList.length);
      } else if (y > 0.425 * height && y < 0.450 * height) {
        // Difficulty down arrow clicked
        level = (level + levelList.length - 1) % (levelList.length);
      }
    } else if (x > 0.35 * width && x < 0.39 * width) {
      if (y > 0.45 * height && y < 0.475 * height && paddleCount < 16) {
        paddleCount++; // Paddle count up
      } else if (y > 0.475 * height && y < 0.5 * height && paddleCount > 0) {
        paddleCount--; // Paddle count down
      } else if (y > 0.5 * height && y < 0.525 * height && puckCount < 16) {
        puckCount++; // Puck count up
      } else if (y > 0.525 * height && y < 0.55 * height && puckCount > 0) {
        puckCount--; // Puck count down
      } else if (y > 0.55 * height && y < 0.575 * height && wallCount < 6) {
        wallCount++; // Wall count up
      } else if (y > 0.575 * height && y < 0.6 * height && wallCount > 0) {
        wallCount--; // Wall count down
      }
    }
  }
}
