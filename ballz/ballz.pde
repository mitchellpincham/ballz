int phase;
int AIMING = 0;
int SHOOTING = 1;
int WAITING = 2;

int ballVel;
int score;
int ballCount;
float angle;
PVector base;
int blockWidth;
int blocksPerRow;
int blockBorder;
boolean firstLanded;

ArrayList<Ball> ballList;
ArrayList<Block> blockList;
ArrayList<BallPickup> ballPickupList;

void setup() {
  size(480, 640);
  ballList = new ArrayList<Ball>();
  blockList = new ArrayList<Block>();
  ballPickupList = new ArrayList<BallPickup>();
  base = new PVector(width / 2, height - 60);

  blocksPerRow = 8;
  blockWidth = width / blocksPerRow;

  firstLanded = true;
  ballVel = 8;
  phase = AIMING;
  score = 1;
  ballCount = 1;
  blockBorder = 2;
  angle = 0;
  generateBlocks();

  colorMode(HSB, 360, 100, 100);
}

void mousePressed() {
  if (phase == AIMING) {
    if (mouseY <= base.y) {
      phase = SHOOTING;
      firstLanded = true;
  
      float dx = mouseX - base.x;
      float dy = mouseY - base.y;
  
      angle = atan2(dy, dx);
    }
  }
}

void aimingPhase() {
  for (Block b : blockList) {
    b.moveDown();
  }
  for (BallPickup b : ballPickupList) {
    b.moveDown();
  }
  generateBlocks();
  phase = AIMING;
  score++;
}

void generateBlocks() {
  int ballpickupx = int(random(blocksPerRow));
  
  for (int x = 0; x < blocksPerRow; x += 1) {
    if (x == ballpickupx) {
      int hs = blockWidth / 2;
      BallPickup b = new BallPickup(x * blockWidth + hs, 3 * hs, 10, blockWidth);
      ballPickupList.add(b);
    } else {
      if (random(1) > 0.5) {
        Block b;
        float x_ = x * blockWidth + blockBorder;
        float y_ = blockWidth + blockBorder;
        float w_ = blockWidth - 2 * blockBorder;
        if (random(1) < 0.1) {
          b = new Block(x_, y_, w_, score * 2);
        } else {
          b = new Block(x_, y_, w_, score);
        }
        blockList.add(b);
      }
    }
  }
}

void drawBlocks() {
  for (Block b : blockList) {
    b.draw();
  }
}

void controlBlocks() {
  for (int i = blockList.size() - 1; i >= 0; i--) {
    if (blockList.get(i).val < 1) {
      blockList.remove(i);
    }
  }
}

void drawBallPickups() {
  for (BallPickup b : ballPickupList) {
    b.draw();
  }
}

void controlBallPickups() {
  for (Ball b : ballList) {
    for (int i = ballPickupList.size() - 1; i >= 0; i--) {
      if (ballPickupList.get(i).touching(b)) {
        ballCount++;
        ballPickupList.remove(i);
      }
    }
  }
}

void drawBalls() {
  for (Ball b : ballList) {
    for (int i = 0; i < ballVel; i++) {
      b.move(blockList);
    }
    b.draw();
  }
}

void controlBalls() {

  // create new ball if needed
  if (ballList.size() < ballCount && frameCount % 5 == 0 && phase == SHOOTING) {
    Ball b = new Ball(base.x, base.y, 6);

    b.vel = new PVector(cos(angle), sin(angle));

    ballList.add(b);
  }

  // check if each ball has hit the bottom and remove it if it has, also remove it if it has a score less than 0.
  for (int i = ballList.size() - 1; i >= 0; i--) {
    if (ballList.get(i).pos.y > height - ballList.get(i).r) {
      if (firstLanded) {
        base.x = ballList.get(i).pos.x;
      }
      firstLanded = false;
      ballList.remove(i);
    }
  }
}

void draw() {
  background(0);

  textSize(20);
  textAlign(RIGHT);
  fill(255);
  text(score, width - 30, 30);

  // if we haven't shot the balls
  if (phase == AIMING) {

    fill(255);
    circle(base.x, base.y, 12);

    // else we have/are shooting the balls.
  } else {

    controlBalls();
    controlBlocks();
    controlBallPickups();

    // if all the balls have hit the bottom then move on to next phase
    if (ballList.size() == 0 && frameCount % 5 == 0) {
      aimingPhase();
    }

    // if all the balls have just been created
    if (ballList.size() == ballCount) {
      phase = WAITING;
    }

    drawBalls();
  }
  drawBallPickups();
  drawBlocks();
}
