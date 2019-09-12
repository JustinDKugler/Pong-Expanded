class Pucks {
  float posX, posY;
  int puckWidth, puckHeight;
  float velX, velY, maxVel = 1;
  final float hitBoxWidth = 1.5; // Used to create a buffer zone around the puck that counts for collision, without it, paddle and puck pos must be exactly ==
  int[] plusOrMinus = {-1, 1};

  Pucks(int puckNumber) {
    puckWidth = int(0.02 * width);
    puckHeight = int(0.02 * width);

    // Start pucks in the center
    posX = int((width - puckWidth) / 2);
    posY = int((height - puckHeight) / 2);

    velX = plusOrMinus[int(random(plusOrMinus.length))] * (maxVel / (pow(1.2, puckNumber))); // Velocity drops off as number of pucks increases
    velY = plusOrMinus[int(random(plusOrMinus.length))] * (maxVel / (pow(1.2, puckNumber))); // Velocity is randomly +- initially
  }

  void display() {
    // Puck hitbox rectangle
    fill(255);
    stroke(100);
    strokeWeight(1); // Large strokes are not part of the hitbox and make collisions overlap
    rect(posX, posY, puckWidth, puckHeight);

    /*// Puck decoration to mess around with
     pushMatrix(); // Read the reference on this, makes translation and rotation functions reset after being used in this function
     fill(100);
     translate(posX + (puckWidth/2), posY + (puckHeight/2)); // Move origin to top of puck
     rotate(radians(frameCount%360)); // Rotate around the origin
     rect(-puckWidth/4, -puckHeight/4, puckWidth/2, puckHeight/2);
     popMatrix(); // Read the reference on this, makes translation and rotation functions reset after being used in this function
     
     pushMatrix();
     fill(50);
     translate(posX + (puckWidth/2), posY + (puckHeight/2) - puckHeight/4); // Move origin to top of puck
     rotate(radians(frameCount%360)); // Rotate around the origin
     rect(-puckWidth/4, -puckHeight/4, puckWidth/2, puckHeight/2);
     popMatrix(); // */
  }

  void move() {
    // Determine the velocity changes from possible collisions
    for ( int i = 0; i < menu.paddleCount; i++) {
      // All collisions test to see if the side of each paddle is within hitbox range of the approiate puck side.
      // The second part of each if (the &&) ensures that the sides overlap in a way that a perpendicular line could pass through both
      // Right side collision
      if (abs((posX) - (paddle[i].posX + paddle[i].paddleWidth)) < hitBoxWidth && 
        posY + puckHeight > paddle[i].posY && posY < paddle[i].posY + paddle[i].paddleHeight) {
        velX = abs(velY);
        game.score++; // Increment score
      }
      // Left side collision
      if (abs((posX + puckWidth) - (paddle[i].posX)) < hitBoxWidth && 
        posY + puckHeight > paddle[i].posY && posY < paddle[i].posY + paddle[i].paddleHeight) {
        velX = -abs(velY);
        game.score++; // Increment score
      }
      // Bottom side collision
      if (abs((posY) - (paddle[i].posY + paddle[i].paddleHeight)) < hitBoxWidth && 
        posX + puckWidth > paddle[i].posX && posX < paddle[i].posX + paddle[i].paddleWidth) {
        velY = abs(velY);
        game.score++; // Increment score
      }
      // Top side collision
      if (abs((posY + puckHeight) - (paddle[i].posY)) < hitBoxWidth && 
        posX + puckWidth > paddle[i].posX && posX < paddle[i].posX + paddle[i].paddleWidth) {
        velY = -abs(velY);
        game.score++; // Increment score
      }
    }
    // Increment puck position
    posX += velX;
    posY += velY;
  }

  Boolean testForLoss() {
    // Puck off right edge
    if (posX > width) {
      return true;
    }
    // Puck off left edge
    if (posX + puckWidth < 0) {
      return true;
    }
    // Puck off bottom edge
    if (posY > height) {
      return true;
    }
    // Puck off top edge
    if (posY + puckHeight < 0) {
      return true;
    }
    return false;
  }
}
