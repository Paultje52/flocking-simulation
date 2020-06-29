// The recangle class, used to draw the 
class rectangle {
  private float width;
  private float height;
  private float posX = 0;
  private float posY = 0;
  private color fill = #A9A9A9;
  private color stroke = #000000;
  
  public rectangle(float width, float height) {
    this.width = width;
    this.height = height;
    this.draw();
  }
  
  public rectangle setColor(float red, float green, float blue) {
    this.remove();
    this.fill = color(red, green, blue);
    this.draw(); 
    return this;
  }
  
  public rectangle setPosition(float x, float y) {
    this.remove();
    this.posX = x;
    this.posY = y;
    this.draw(); 
    return this;
  }
  
  public rectangle setBorder(float red, float green, float blue) {
    this.stroke = color(red, green, blue);
    return this;
  }
  
  public rectangle move(String direction, float amount) {
    this.remove();
    if (direction == "right") this.posX += amount;
    else if (direction == "left") this.posX -= amount;
    else if (direction == "up") this.posY -= amount;
    else if (direction == "down") this.posY += amount;
    this.draw();
    return this;
  }
  
  private void draw() {
    fill(this.fill);
    stroke(this.stroke);
    rect(this.posX, this.posY, this.width, this.height);
  }
  private void remove() {
    fill(g.backgroundColor);
    stroke(g.backgroundColor);
    rect(posX, posY, width, height);
  }
}
