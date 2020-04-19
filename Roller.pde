import java.util.*;

public class Roller implements Button {
  private int x, y;
  private Random random;
  private int lastRoll = 0;
  private boolean rolled = false;
  private boolean[] rolls = new boolean[4];
  
  public Roller(int x, int y) {
    this.x = x;
    this.y = y;
    random = new Random();
    for(int i = 0; i < rolls.length; i++) {
      rolls[i] = false;
    }
  }
  
  public void render() {
    //Button
    strokeWeight(2);
    stroke(0);
    if(isMouseOver() && !rolled) {
      fill(0, 255, 255);
    } else if(rolled) {
      fill(255, 255, 255);
    } else {
      fill(127, 255, 184);
    }
    rect(x, y, 200, 100);
    
    //Number
    strokeWeight(4);
    textSize(36);
    if(rolled) {
      text("Roll:" + lastRoll, x-50, y+150);
    } else {
      text("Roll: -", x-50  , y+150);
    }
    
    //Circles
    strokeWeight(2);
    for(int i = 0; i < rolls.length; i++) {
      if(rolls[i]) {
        fill(0, 255, 0);
      } else {
        fill(0, 0, 0);
      }
      circle(x-50+30*i, y+75, 20);
    }
  }
  
  public void onClick() {
    if(isMouseOver() && !rolled) {
      roll();
    }
  }
  
  public boolean hasRolled() {
    return rolled;
  }
  
  public int getRoll() {
    return lastRoll;
  }
  
  public void roll() {
    int outcome = 0;
    for(int i = 0; i < 4; i++) {
      if(random.nextBoolean()) {
        rolls[i] = true;
        outcome += 1;
      } else {
        rolls[i] = false; 
      }
    }
    lastRoll = outcome;
    rolled = true;
  }
  
  public void release() {
    rolled = false;
  }
  
  //Figures out if the mouse is over this button and returns it.
  public boolean isMouseOver(){
    //2D overlapping logic again!
    if(mouseX > x-100 && mouseX < x+100 && mouseY > y-50 && mouseY < y+50){
      return true;
    }else{
       return false;
    }
  }
}
