class Block {
  PVector pos;
  float wid;
  int val;
  
  Block(float x, float y, float wid_, int val_) {
    pos = new PVector(x, y);
    this.wid = wid_;
    this.val = val_;
  }
  
  void draw() {
    fill((val * 5 + 50) % 360, 100, 100);
    rect(this.pos.x, this.pos.y, this.wid, this.wid, 12);
    
    textAlign(CENTER, CENTER);
    fill(0, 0, 100);
    
    text(this.val, this.pos.x + this.wid / 2, this.pos.y + this.wid / 2);
  }
  
  void moveDown() {
    this.pos.y += this.wid;
  }
}
