//Variables and stuff
Board board;
Roller roller;
List<Button> buttons = new ArrayList<Button>();

static final boolean RED = false;
static final boolean BLUE = true;

boolean turn = RED;

Player red;
Player blue;

//Setting up all of the default variables guarentees it is exactly how we expect regardless what else has happened.
void setup() {
  size(1536, 864, P2D);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textSize(24);
  frameRate(30); //We don't need to try for 60 fps in this game so lets take the extra processing time.
  
  //Now initalize
  board = new Board();
  roller = new Roller(1300, 150);
  buttons.add(roller);
  red = new Player(RED);
  red.setupPieces(width/2 - 300, 50);
  blue = new Player(BLUE);
  blue.setupPieces(width/2 + 300, 50);
  buttons.add(red);
  buttons.add(blue);
  buttons.add(board);
}

void draw() {
  background(0, 0, 158); //Draws the default background
  
  //Now render
  board.render();
  roller.render();
  red.render();
  blue.render();
  //Text to show who's turn it is
  strokeWeight(4);
  textSize(36);
  if(turn == RED) {
    fill(255, 0, 0);
    text("Red's Turn", 100, 50);
  } else {
    fill(0, 0, 255);
    text("Blue's Turn", 100, 50);
  }
}

void rosette() {
  roller.release();
}

void nextTurn() {
  turn = !turn;
  roller.release();
}

//When the mouse is clicked see if a tile can be played.
void mousePressed() {
  for (Button b : buttons) {
    b.onClick();
  }
}
