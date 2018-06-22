class Life_Five {
  int x;
  int y;
  int background_color;

  Life_Five (int x_temporal, int y_temporal, int temporal_background_color) {
    x = x_temporal;
    y = y_temporal;
    background_color = temporal_background_color;
  }

  void position_five(int pos_x, int pos_y) {
    myKnobE = cp5_five.addKnob("Life")
      .setFont(life_title)
      .setViewStyle(3)
      .setRange(0, 5)
      .setValue(life_PFive)
      .setPosition(pos_x, pos_y)
      .setRadius(120)
      .hideTickMarks()
      .setNumberOfTickMarks(5)
      .setTickMarkLength(8)
      .setTickMarkWeight(3)
      .snapToTickMarks(true)
      .setColorForeground(color(#baffc9, 191))
      .setColorBackground(background_color)
      //.setColorActive(color(255,255,0))
      .setDragDirection(Knob.VERTICAL)
      ;
  }
  void display_five(int life_temporal) {
    myKnobE.setValue(life_temporal);
    if(life_temporal > 3) {
            noStroke();
            fill(69, 252, 131);
            ellipse(x, y, 40, 40);
    }
    if((life_temporal <= 3) && (life_temporal > 1)) {
      //If the user end the game change the color to yellow
      noStroke();
      fill(#fff74d);
      ellipse(x, y, 40, 40);
      background_death_one = color(#fff74d);
      myKnobE.setColorForeground(#794DFF);
      myKnobE.setColorBackground(background_death_one);
      myKnobE.setColorValueLabel(#05A73F);
    }
    if (life_temporal <= 1) {
      //If the user end the game change the color to red
      noStroke();
      fill(#ff2301);
      ellipse(x, y, 40, 40);
      background_death_one = color(#ff2301);
      myKnobE.setColorBackground(background_death_one);
      myKnobE.setColorValue(255);
    }
  }
}
