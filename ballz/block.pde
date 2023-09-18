class Block {
  PVector pos;
  int wid;
  Block(int x, int y, int wid_) {
    pos = new PVector(x, y);
    this.wid = wid_;
  }
  
  void draw() {
    fill(255, 0, 0);
    square(this.pos.x, this.pos.y, this.wid);
  }
}
