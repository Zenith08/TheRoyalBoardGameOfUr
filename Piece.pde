import java.util.*;

public class Piece implements Button {
  public static final boolean RED = false;
  public static final boolean BLUE = true;
  private static final int RADIUS = 40;
  private static final int DIAMETER = RADIUS*2;
  
  private boolean side;
  
  private int x, y;
  private final int startX, startY;
  
  private int position = 0;
  
  private boolean selected = false;
  
  public Piece(int x, int y, boolean side) {
    this.x = x;
    this.y = y;
    this.startX = x;
    this.startY = y;
    this.side = side;
  }
  
  public void render() {
    strokeWeight(2);
    stroke(0);
    if(side == BLUE && !selected) {
      fill(0, 0, 255);
    } else if (side == BLUE && selected) {
      fill(100, 100, 255);
    } else if (side == RED && selected) {
      fill(255, 100, 100);
    } else if (side == RED && !selected) {
      fill(255, 0, 0);
    } else {
      fill(0); //This is an error state.
    }
    circle(x, y, DIAMETER);
  }
  
  public void onClick() {
    if(isMouseOver() && turn == side && roller.hasRolled()) {
      if(roller.getRoll() == 0) {
        nextTurn();
      } else {
        selected = true;
        //Request Button
        board.requestButton(side, position+roller.getRoll(), this);
      }
    } else {
      selected = false;
    }
  }
  
  public boolean hasMove() {
    return board.canPieceGoTo(side, position+roller.getRoll(), this);
  }
  
  public void finish() {
    board.requestEndOccupancy(side, position);
    
    position = 15;
    this.x = 2000;
    this.y = 2000;
  }
  
  public boolean isSelected() {
    return selected;
  }
  
  public void requestMove(Tile target) {
    board.requestEndOccupancy(side, position);
    this.x = target.getX();
    this.y = target.getY();
    position += roller.getRoll();
    board.requestOccupancy(side, position, this);
  }
  
  public boolean getSide() {
    return side;
  }
  
  public void eject() {
    //System.out.println("Piece ejected, setting x " + x + " y " + y);
    position = 0;
    x = startX;
    y = startY;
  }
  
  private boolean isMouseOver() {
    // Compare radius of circle with 
    // distance of its center from 
    //given point 
    if ((mouseX - x) * (mouseX - x) + 
      (mouseY - y) * (mouseY - y) <= RADIUS * RADIUS) {
      return true; 
    } else {
      return false; 
    }
  }
}
