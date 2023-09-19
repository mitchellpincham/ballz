int phase;
int AIMING = 0;
int SHOOTING = 1;
int WAITING = 2;

int ballVel;
int score;
float angle;
PVector base;
int blockWidth;
int blocksPerRow;

ArrayList<Ball> ballList;
ArrayList<Block> blockList;

void setup() {
  size(480, 640);
  ballList = new ArrayList<Ball>();
  blockList = new ArrayList<Block>();
  base = new PVector(width / 2, height - 60);

  blocksPerRow = 10;
  blockWidth = width / blocksPerRow;

  ballVel = 8;
  phase = AIMING;
  score = 1;
  angle = -3 * PI / 4;
  generateBlocks();
}

void mousePressed() {
  phase = SHOOTING;

  float dx = mouseX - base.x;
  float dy = mouseY - base.y;

  angle = atan2(dy, dx);
}

void aimingPhase() {
  score++;
  for (Block b : blockList) {
    b.moveDown();
  }
  generateBlocks();
  phase = AIMING;
}

void generateBlocks() {
  for (int x = 0; x < width; x += blockWidth) {
    if (random(1) > 0.5) {
      Block b = new Block(x, blockWidth, blockWidth, score);
      blockList.add(b);
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
  if (ballList.size() < score && frameCount % 5 == 0 && phase == SHOOTING) {
    Ball b = new Ball(base.x, base.y, 6);
    
    b.vel = new PVector(cos(angle), sin(angle));

    ballList.add(b);
  }
  
  // check if each ball has hit the bottom and remove it if it has, also remove it if it has a score less than 0.
  for (int i = ballList.size() - 1; i >= 0; i--) {
    if (ballList.get(i).pos.y > height - ballList.get(i).r) {
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
    
    // if all the balls have hit the bottom then move on to next phase
    if (ballList.size() == 0 && frameCount % 5 == 0) {
      aimingPhase();
    }
  
    // if all the balls have just been created
    if (ballList.size() == score) {
      phase = WAITING;
    }
    
    drawBalls();
  }
  drawBlocks();
}
