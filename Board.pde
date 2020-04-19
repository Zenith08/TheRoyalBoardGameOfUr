import java.util.*;

public class Board implements Button {
  int middle;
  int left;
  int right;
  private Map<String, Tile> tiles = new HashMap<String, Tile>();
  private FinishButton redFinish;
  private FinishButton blueFinish;
  
  public Board() {
    middle = width/2;
    left = middle-100;
    right = middle+100;
    
    //4 on top left
    tiles.put("red4", new Tile(Tile.RED, Tile.ROSETTE, left, 50));
    tiles.put("red3", new Tile(Tile.RED, Tile.NORM, left, 150));
    tiles.put("red2", new Tile(Tile.RED, Tile.NORM, left, 250));
    tiles.put("red1", new Tile(Tile.RED, Tile.NORM, left, 350));
    
    //4 on top right
    tiles.put("blue4", new Tile(Tile.BLUE, Tile.ROSETTE, right, 50));
    tiles.put("blue3", new Tile(Tile.BLUE, Tile.NORM, right, 150));
    tiles.put("blue2", new Tile(Tile.BLUE, Tile.NORM, right, 250));
    tiles.put("blue1", new Tile(Tile.BLUE, Tile.NORM, right, 350));
    
    //8 down middle
    tiles.put("both5", new Tile(middle, 50));
    tiles.put("both6", new Tile(middle, 150));
    tiles.put("both7", new Tile(middle, 250));
    tiles.put("both8", new Tile(Tile.BOTH, Tile.ROSETTE, middle, 350));
    tiles.put("both9", new Tile(middle, 450));
    tiles.put("both10", new Tile(middle, 550));
    tiles.put("both11", new Tile(middle, 650));
    tiles.put("both12", new Tile(middle, 750));
    
    //skip 2
    tiles.put("red14", new Tile(Tile.RED, Tile.ROSETTE, left, 650));
    tiles.put("red13", new Tile(Tile.RED, Tile.NORM, left, 750));
    
    //skip 2
    tiles.put("blue14", new Tile(Tile.BLUE, Tile.ROSETTE, right, 650));
    tiles.put("blue13", new Tile(Tile.BLUE, Tile.NORM, right, 750));
    
    redFinish = new FinishButton(left, 550, RED);
    blueFinish = new FinishButton(right, 550, BLUE);
  }
  
  public void render() {
    for(Tile t : tiles.values()) {
      t.render();
    }
    redFinish.render();
    blueFinish.render();
  }
  
  public void onClick() {
    for(Tile t : tiles.values()) {
      t.onClick();
    }
    redFinish.onClick();
    blueFinish.onClick();
  }
  
  public void requestButton(boolean colour, int tileIndex, Piece requestor) {
    if(tileIndex > 0 && tileIndex <= 14){
      getTileAt(colour, tileIndex).requestButton(requestor);
    } else if (tileIndex == 15) {
      if(colour == RED) {
        redFinish.enable(requestor);
      } else {
        blueFinish.enable(requestor);
      }
    }
  }
  
  public void requestOccupancy(boolean colour, int tileIndex, Piece replacer) {
    //System.out.println("Occupancy requested by " + colour + " for tile " + tileIndex);
    if(tileIndex > 0 && tileIndex <= 14){
      //System.out.println("Within range");
      getTileAt(colour, tileIndex).requestOccupancy(replacer);
    }
  }
  
  public void requestEndOccupancy(boolean colour, int tileIndex) {
    if(tileIndex > 0 && tileIndex <= 14) {
      getTileAt(colour, tileIndex).endOccupancy();
    }
  }
  
  public boolean canPieceGoTo(boolean colour, int tileIndex, Piece piece) {
    if(tileIndex > 0 && tileIndex <= 14) {
      return getTileAt(colour, tileIndex).canPieceOccupy(piece);
    } else if(tileIndex == 15) {
      return true;
    } else {
      return false;
    }
  }
  
  public Tile getTileAt(boolean colour, int tileIndex) {
    if(tileIndex > 4 && tileIndex < 13) {
      return tiles.get("both" + tileIndex);
    } else {
      return tiles.get(teamToString(colour) + tileIndex);
    }
  }
  
  public String teamToString(boolean team){
    if(team == RED){
      return "red";
    }else{
      return "blue";
    }
  }
}

public class FinishButton implements Button{
  private boolean side;
  private boolean enabled;
  private int x, y;
  
  private Piece requestor;
  
  private static final int WIDTH = 50, HEIGHT = 30;
  
  public FinishButton(int x, int y, boolean side) {
    enabled = false;
    this.x = x;
    this.y = y;
    this.side = side;
  }
  
  public void onClick() {
    if(isMouseOver() && enabled) {
      requestor.finish();
      nextTurn();
    }
  }
  
  public void enable(Piece requestor) {
    enabled = true;
    this.requestor = requestor;
  }
  
  public void disable() {
    enabled = false;
  }
  
  public void render() {
    if(requestor != null) {
      if(!requestor.isSelected()){
        enabled = false;
        requestor = null;
      }
    }
    
    if(enabled) {
      strokeWeight(2);
      stroke(0);
      if(side){
        fill(0, 0, 255);
      }else{
        fill(255, 0, 0);
      }
      rect(x, y, WIDTH, HEIGHT);
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
