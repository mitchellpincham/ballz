class Block {
  PVector pos;
  int wid;
  int val;
  
  Block(int x, int y, int wid_, int val_) {
    pos = new PVector(x, y);
    this.wid = wid_;
    this.val = val_;
  }
  
  void draw() {
    fill(255, 0, 0);
    square(this.pos.x, this.pos.y, this.wid);
    
    textAlign(CENTER, CENTER);
    fill(255);
    text(this.val, this.pos.x + this.wid / 2, this.pos.y + this.wid / 2);
  }
  
  void moveDown() {
    this.pos.y += this.wid;
  }
}
