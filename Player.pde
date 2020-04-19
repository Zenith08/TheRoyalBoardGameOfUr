public class Player implements Button {
  private List<Piece> pieces;
  private boolean colour; //False is red
  private boolean hasMove = true;
  
  public Player(boolean colour) {
    pieces = new ArrayList<Piece>(7);
    this.colour = colour;
  }
  
  public void setupPieces(int x, int y1) {
    for(int i = 0; i < 7; i++) {
      pieces.add(new Piece(x, y1+100*i, colour));
    }
  }
  
  public void render() {
    //Logic
    if(turn == colour && roller.hasRolled()) {
      hasMove = hasMove();
    }
    
    for(Piece p : pieces) {
      p.render();
    }
  }
  
  private boolean hasMove() {
    for(Piece p : pieces) {
      if(p.hasMove()) {
        return true;
      }
    }
    return false;
  }
  
  public void onClick() {
    if(turn == colour && !hasMove) {
      nextTurn();
      hasMove = true;
    }
    for(Piece p : pieces) {
      p.onClick();
    }
  }
}
