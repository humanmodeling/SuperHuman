class Life_Three {
  int x;
  int y;
  int background_color;

  Life_Three (int x_temporal, int y_temporal, int temporal_background_color) {
    x = x_temporal;
    y = y_temporal;
    background_color = temporal_background_color;
  }

  void position_three(int pos_x, int pos_y) {
    myKnobC = cp5_three.addKnob("Life")
      .setFont(life_title)
      .setViewStyle(3)
      .setRange(0, 5)
      .setValue(life_PThree)
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

  void display_three(int life_temporal) {
    myKnobC.setValue(life_temporal);
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
      myKnobC.setColorForeground(#794DFF);
      myKnobC.setColorBackground(background_death_one);
      myKnobC.setColorValueLabel(#05A73F);
    }
    if (life_temporal <= 1) {
      //If the user end the game change the color to red
      noStroke();
      fill(#ff2301);
      ellipse(x, y, 40, 40);
      background_death_one = color(#ff2301);
      myKnobC.setColorBackground(background_death_one);
      myKnobC.setColorValue(255);
    }
  }
}
