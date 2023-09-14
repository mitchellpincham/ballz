boolean moveable;

float ballx;
int score;

ArrayList<Ball> balllist;

void setup() {
  size(640, 480);
  balllist = new ArrayList<Ball>();
  
  ballx = width / 2;
  
  moveable = false;
  score = 3;
}

void draw() {
  background(0);
  
  textSize(20);
  textAlign(RIGHT);
  fill(255);
  text(score, width - 30, 30);
  
  if (moveable) {
    
    fill(255);
    circle(ballx, height - 60, 10);
    
  } else {
    if (balllist.size() < score && frameCount % 5 == 0) {
      Ball b = new Ball(ballx, height - 60, 10);
      
      b.vel = new PVector(-1, -1);
      
      balllist.add(b);
    }
    
    for (Ball b : balllist) {
      for (int i = 0; i < 5; i++) {
        b.move();
        
        if (b.pos.y > height - b.r) {
          balllist.remove(b);
        }
      }
      b.draw();
    }
  }
}
