class Ball {
  PVector pos;
  PVector vel;
  float r;
  Ball(float x_, float y_, float r_) {
    this.pos = new PVector(x_, y_);
    this.r = r_;
  }

  boolean touching(Block b) {
    // if touching on x axis
    return (this.pos.x + this.r >= b.pos.x && this.pos.x - this.r <= b.pos.x + b.wid)
      // if touching on Y axis
      && (this.pos.y + this.r >= b.pos.y && this.pos.y - this.r <= b.pos.y + b.wid);
  }

  void move(ArrayList<Block> blocks) {
    this.pos.x += this.vel.x;

    for (Block b : blocks) {
      if (this.touching(b)) {
        b.val--;
        this.vel.x *= -1;
        this.pos.x += this.vel.x;
        break;
      }
    }

    this.pos.y += this.vel.y;

    for (Block b : blocks) {
      if (this.touching(b)) {
        b.val--;
        this.vel.y *= -1;
        this.pos.y += this.vel.y;
        break;
      }
    }

    if (this.pos.x < r || this.pos.x > width - r) {
      this.vel.x *= -1;
    }
    if (this.pos.y < r) {
      this.vel.y *= -1;
    }
  }

  void draw() {
    fill(255);
    circle(this.pos.x, this.pos.y, this.r * 2);
  }
}
