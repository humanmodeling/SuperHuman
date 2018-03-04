class Pwindow extends PApplet {
  Pwindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  
  void setting() {
    size(500, 200);
  }
  
  void setup() {
    background(150);
  }
  
  void draw() {
    ellipse(random(width), random(height), random(50), random(50));
  }
  void mousePressed() {
    println("mousePressed in secondary window");
  }
}