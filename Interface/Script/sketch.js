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
  text("Kishishita", width/13, height/6);

  arc(width/6, height/3, 180, 180, myAngle/2, 360 - myAngle/2);

  // life ellipse
  fill(myColor);
  arc(width/6, height/3, 150, 150, myAngle/2, 360 - myAngle/2);

  fill(255);
  textSize(32);
  text("life", width/6.6, height/1.9);

}


// dynamically adjust the canvas to the window
function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
