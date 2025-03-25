int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

boolean[] toggles = new boolean[6];
String[] togglesT = {"Moving", "Bounce", "Grav", "Drag", "Collision", "Propulsion"};
boolean[] sim = new boolean[5];
String[] simT = {"Orbit", "Spring", "Drag", "Collisions", "Combination"};
int SPRING_LENGTH;
float  SPRING_K = 0.005;

int moving = 1;
int bounce = 2;
int grav = 3;
int drag = 4;
int collision = 5;
int propulsion = 6;

OrbList ol;

void setup() {
  size(800, 800);
  SPRING_LENGTH = (width-10)/(NUM_ORBS+1);
  ol = new OrbList(NUM_ORBS, true);
  println(SPRING_LENGTH);
}

void draw() {
  modeButtons();
  background(255);
  ol.display();
  ol.run(false, SPRING_LENGTH);
}

void keyPressed() {
  if (key == ' ') { toggles[moving] = !toggles[moving]; }
  if (key == 'b') { toggles[bounce] = !toggles[bounce]; }
  if (key == 'g') { toggles[grav] = !toggles[grav]; }
  if (key == 'd') { toggles[drag] = !toggles[drag]; }
  if (key == 'c') { toggles[collision] = !toggles[collision]; }
  if (key == 'p') { toggles[propulsion] = !toggles[propulsion]; }
}

void modeButtons() {
  textSize(30); 
  int x = 0;
  
  for (int m = 0; m < toggles.length; m++) {
    // set box color
    if (toggles[m]) { 
      fill(0, 255, 0); 
    } else { 
      fill(255, 0, 0); 
    }

    float w = textWidth(togglesT[m]);
    rect(x, 0, w + 5, 30);
    fill(0);
    text(togglesT[m], x + 2, 22);
    x += w + 10; // Adjust spacing between buttons

  }
}
//void text() {
//  fill(255,50,50);
//  for(int i = 0; i < toggles.length; i++) {
//    rect(
//  }
//}
