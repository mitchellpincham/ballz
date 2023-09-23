class BallPickup {
  PVector pos;
  int r;
  int blockSize;
  
  BallPickup(int x, int y, int r_, int bs) {
    this.pos = new PVector(x, y);
    this.r = r_;
    this.blockSize = bs;
  }
  
  boolean touching(Ball b) {
    return(sq(this.r) + sq(b.r) >= sq(pos.dist(b.pos)));
  }
  
  void draw() {
    fill(0, 0, 100);
    circle(this.pos.x, this.pos.y, this.r * 2);
  }
  
  void moveDown() {
    this.pos.y += this.blockSize;
  }
}
