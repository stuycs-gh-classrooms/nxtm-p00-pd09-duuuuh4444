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
  background(255);
  ol.display();
  ol.run(false, SPRING_LENGTH);
  modeButtons();
}

void modeButtons() {
  textSize(18);
  int sectionWidth = width / toggles.length;
  int buttonHeight = 30;
  
  for (int m = 0; m < toggles.length; m++) {
    String label = togglesT[m];
    
    // Draw button background
    if (toggles[m]) {
      fill(76, 175, 80);  // Green when on
    } else {
      fill(244, 67, 54);  // Red when off
    }
    
    stroke(0);
    strokeWeight(1);
    rect(m * sectionWidth, 5, sectionWidth, buttonHeight, 5); // Rounded corners
    
    // Draw label centered in each section
    fill(255);
    textAlign(CENTER, CENTER);
    text(label, m * sectionWidth + sectionWidth/2, 5 + buttonHeight/2);
  }
}

void mouseClicked() {
  // Process clicks between y = 5 and y = 35
  if (mouseY >= 5 && mouseY <= 35) {
    // Iterate through toggles
    for (int i = 0; i < toggles.length; i++) {
      // Check horizontal position
      if (mouseX < (i + 1) * (width / toggles.length)) {
        // Toggle the corresponding boolean
        toggles[i] = !toggles[i];
        break;
      }
    }
  }
}

void keyPressed() {
  // Existing key toggles (now synced with mouse)
  if (key == ' ') toggles[0] = !toggles[0]; // Moving
  if (key == 'b') toggles[1] = !toggles[1]; // Bounce
  if (key == 'g') toggles[2] = !toggles[2]; // Grav
  if (key == 'd') toggles[3] = !toggles[3]; // Drag
  if (key == 'c') toggles[4] = !toggles[4]; // Collision
  if (key == 'p') toggles[5] = !toggles[5]; // Propulsion
}
