class Paddle {
  float posX, posY;
  int paddleWidth, paddleHeight;
  float velX = 2, velY = 2;
  Boolean xMovement, yMovement;

  Paddle(Boolean tempXMovement, Boolean tempYMovement, float axis, float position) { // Used for basic paddles, position allows 8 multiple coaxial paddles, 20 axes
    xMovement = tempXMovement;
    yMovement = tempYMovement;

    if (xMovement) {
      paddleWidth = int(0.06 * width);
    } else {
      paddleWidth = int(0.01 * width);
    }
    if (yMovement) {
      paddleHeight = int(0.06 * width);
    } else {
      paddleHeight = int(0.01 * width);
    }

    if (xMovement) {
      posX = ((width * position)/8) - paddleWidth;
      posY = ((axis * height)/20);
    }
    if (yMovement) {
      posX = ((axis * width)/20);
      posY = ((height * position)/8) - paddleHeight;
    }
    if (xMovement && yMovement) {
      posX = ((axis * width)/20);
      posY = ((axis * height)/20);
    }
  }

  Paddle(int wallNumber) { // Used for walls, 1 - right, 2 - top, 3 - left, 4 - bottom, 5 - center cube
    xMovement = false;
    yMovement = false;
    switch(wallNumber) {
    case 1:
      posX = width - 10;
      posY = 0;
      paddleWidth = 10;
      paddleHeight = height;
      break;
    case 2:
      posX = 0;
      posY = 0;
      paddleWidth = width;
      paddleHeight = 10;
      break;
    case 3:
      posX = 0;
      posY = 0;
      paddleWidth = 10;
      paddleHeight = height;
      break;
    case 4:
      posX = 0;
      posY = height - 10;
      paddleWidth = width;
      paddleHeight = 10;
      break;
    case 5:
      posX = 0.3 * width;
      posY = 0.35 * height;
      paddleWidth = int(0.4 * width);
      paddleHeight = int(0.05 * height);
      break;
    case 6:
      posX = 0.3 * width;
      posY = 0.6 * height;
      paddleWidth = int(0.4 * width);
      paddleHeight = int(0.05 * height);
      break;
    default:
      break;
    }
  }

  void display() {
    fill(0, 255, 0);
    stroke(0, 255, 0);
    strokeWeight(0);
    rect(posX, posY, paddleWidth, paddleHeight);
  }

  void move() {
    if (xMovement) {
      if (game.moveLeft) {
        posX = (posX - velX) % width;
        if (posX < -paddleWidth) {
          posX = width - paddleWidth;
        }
      }
      if (game.moveRight) {
        posX = (posX + velX) % width;
      }
    }
    if (yMovement) {
      if (game.moveUp) {
        posY = (posY - velX) % height;
        if (posY < -paddleHeight) {
          posY = height - paddleHeight;
        }
      }
      if (game.moveDown) {
        posY = (posY + velY) % height;
      }
    }
  }
}
