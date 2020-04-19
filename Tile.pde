public class Tile implements Button {
  //Static Class Level Stuff
  public static final byte BOTH = 0;
  public static final byte RED = 1;
  public static final byte BLUE = 2;
  public static final boolean NORM = false;
  public static final boolean ROSETTE = true;
  
  private byte side;
  private boolean rosette;
  private int x, y;
  
  private boolean buttonActive = false;
  private Piece buttonRequest;
  private Piece occupant;
  
  public Tile(byte side, boolean rosette, int x, int y) {
    this.side = side;
    this.rosette = rosette;
    this.x = x;
    this.y = y;
  }
  
  public Tile(int x, int y) {
    this(BOTH, NORM, x, y);
  }
  
  public void render() {
    strokeWeight(2);
    stroke(0);
    
    if(buttonActive && buttonRequest != null) {
      if(!buttonRequest.isSelected()) {
        buttonActive = false;
        buttonRequest = null;
      }
    }
    
    if(rosette) {
      if(buttonActive) {
        fill(255, 255, 91);
      } else {
        fill(255, 0, 91);
      }
    } else {
      if(buttonActive) {
        fill(0, 255, 0);
      } else {
        fill(255, 140, 91);
      }
    }
    rect(x, y, 100, 100);
  }
  
  public void requestOccupancy(Piece replacer) {
    //System.out.println("occupancy requested on tile by " + replacer.getSide());
    if(occupant != null && occupant.getSide() != replacer.getSide()) {
      occupant.eject();
      //System.out.println("Eject called?");
    }
    occupant = replacer;
  }
  
  public void endOccupancy() {
    occupant = null;
  }
  
  public void onClick() {
    //System.out.println("on click of tile, data MouseOver: " + isMouseOver() + " button active " + buttonActive);
    if(isMouseOver() && buttonActive && buttonRequest != null) {
      buttonRequest.requestMove(this);
      //System.out.println("Move requested");
      if(rosette) {
        rosette();
      }else{
        nextTurn();
      }
    }
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
  
  public void requestButton(Piece requestor) {
    if(canPieceOccupy(requestor)) {
      buttonActive = true;
      this.buttonRequest = requestor;
    }
  }
  
  public boolean canPieceOccupy(Piece requestor) {
    if(occupant == null) {
      return true;
    }else if(occupant.getSide() == requestor.getSide()){
      return false;
    }else if(rosette){
      return false;
    }else{
      return true;
    }
  }
  
  //Figures out if the mouse is over this button and returns it.
  public boolean isMouseOver(){
    //2D overlapping logic again!
    if(mouseX > x-50 && mouseX < x+50 && mouseY > y-50 && mouseY < y+50){
      return true;
    }else{
       return false;
    }
  }
}
