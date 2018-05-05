// gui params
var myAngle = 0;
var myColor = '#30ee00';

var gui;

function setup() {

  createCanvas(windowWidth, windowHeight);

  // Create the GUI
  //sliderRange(0, 90, 1);
  //gui = createGui('p5.gui');
  //gui.addGlobals('myColor', 'myAngle');

  // Only call draw when then gui is changed
  noLoop();
  angleMode(DEGREES);

}


function draw() {

  // this is a piece of cake
  background(0);

  // First user
  fill(255);
  textSize(64);
  text("Kishishita", 110, 100);

  // life ellipse
  //outsice
  arc(240, 200, 180, 180, 0, 360);
  //inside
  fill(myColor);
  arc(240, 200, 160, 160, myAngle/2, 360 - myAngle/2);

  fill(255);
  textSize(32);
  text("life", 220, 320);

}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
