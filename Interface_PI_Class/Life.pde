class Life {
  int life_player;
  int x;
  int y;

  Life(int x_temporal, int y_temporal) {
    x = x_temporal;
    y = y_temporal;
  }

  void display(int life_temporal) {
    life_player = life_temporal;
    if(life_player > 3) {
            noStroke();
            fill(69, 252, 131);
            ellipse(x, y, 40, 40);
    }
    if((life_player <= 3) && (life_player > 1)) {
            //If the user end the game change the color to yellow
            noStroke();
            fill(#fff74d);
            ellipse(x, y, 40, 40);
            background_death_one = color(#fff74d);
            myKnobA.setColorForeground(#794DFF);
            myKnobA.setColorBackground(background_death_one);
            myKnobA.setColorValueLabel(#05A73F);
    }
    if (life_player <= 1) {
            //If the user end the game change the color to red
            noStroke();
            fill(#ff2301);
            ellipse(x, y, 40, 40);
            background_death_one = color(#ff2301);
            myKnobA.setColorBackground(background_death_one);
            myKnobA.setColorValue(255);
    }
  }
}
