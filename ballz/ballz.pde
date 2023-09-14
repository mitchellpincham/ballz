boolean moveable;
boolean ballsCreated;


int score;
float angle;
PVector base;

ArrayList<Ball> ballList;

void setup() {
  size(640, 480);
  ballList = new ArrayList<Ball>();
  base = new PVector(width / 2, height - 60);
  
  
  moveable = true;
  ballsCreated = false;
  score = 3;
  angle = -3 * PI / 4;
}

void mousePressed() {
  moveable = false;
  ballsCreated = false;
  
  float dx = mouseX - base.x;
  float dy = mouseY - base.y;
  
  angle = atan2(dy, dx);
}

void draw() {
  background(0);
  
  textSize(20);
  textAlign(RIGHT);
  fill(255);
  text(score, width - 30, 30);
  
  if (moveable) {
    
    fill(255);
    circle(base.x, base.y, 10);
    
  } else {
    if (ballList.size() < score && frameCount % 5 == 0 && !ballsCreated) {
      Ball b = new Ball(base.x, base.y, 5);
      
      b.vel = new PVector(cos(angle), sin(angle));
      
      ballList.add(b);
    }
    
    if (ballList.size() == score) {
      ballsCreated = true;
    }
    
    if (ballList.size() == 0 && frameCount % 5 == 0) {
      moveable = true;
    }
    
    for (Ball b : ballList) {
      for (int i = 0; i < 5; i++) {
        b.move();
      }
      b.draw();
    }
    
    for (int i = ballList.size() - 1; i >= 0; i--) {
      if (ballList.get(i).pos.y > height - ballList.get(i).r) {
        ballList.remove(i);
      } 
    }
  }
}
