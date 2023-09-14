class Ball {
  PVector pos;
  PVector vel;
  float r;
  Ball(float x_, float y_, float r_) {
    this.pos = new PVector(x_, y_);
    this.r = r_;
  }
  
  void move() {
    this.pos = this.pos.add(this.vel);
    if (this.pos.x < r || this.pos.x > width - r) {
      this.vel.x *= -1;
    }
    if (this.pos.y < r) {
      this.vel.y *= -1;
    }
  }
  
  void draw() {
    fill(255);
    circle(this.pos.x, this.pos.y, this.r);
  }
}
