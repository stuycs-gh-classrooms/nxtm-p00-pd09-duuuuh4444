int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
int MIN_RAD = 50;
int MAX_RAD = 200;
float MIN_FORCE = 1;
float MAX_FORCE = 5;
float MIN_MASS = 1;
float MAX_MASS = 10;
float G_CONSTANT = 0.1;
float LG_CONSTANT = 0.01;
float D_COEF = 0.1;

boolean ordered;
boolean[] toggles = new boolean[9];
String[] togglesT = {"Moving", "Bounce", "Grav", "Drag", "Collision", "Propulsion", "Fall", "Springs", "LGrav"};
boolean[] sim = new boolean[5];
String[] simT = {"Orbit", "Spring", "Drag", "Shockwave", "Combination"};
int SPRING_LENGTH;
float  SPRING_K = 0.005;

int moving = 0;
int bounce = 1;
int grav = 2;
int drag = 3;
int collision = 4;
int propulsion = 5;
int fall = 6;
int spring = 7;
int lgrav = 8;

OrbList ol;

void setup() {
  size(800, 800);
  ordered = true;
  SPRING_LENGTH = (width-10)/(NUM_ORBS+1);
  ol = new OrbList(NUM_ORBS, ordered);
  println(SPRING_LENGTH);
}

void draw() {
  background(255);
  modeButtons();
  ol.display(SPRING_LENGTH);
  if (toggles[moving]) {
    if (toggles[fall]) {
      ol.applyForce(new PVector(0, 0.1));
    }// Fall
    if (toggles[spring]) {
      ol.applySprings(SPRING_LENGTH, SPRING_K);
    }// Springs
    if (toggles[drag]) {
      ol.applyDrag(D_COEF);
    }// Drag
    if (toggles[grav]) {
      ol.applyGravity(G_CONSTANT);
    } // Next/Prev grav
    if (toggles[lgrav]) {
      ol.applyGravityList(LG_CONSTANT);
    } // All orbs grav
    if (toggles[propulsion] && mousePressed) {
      int rad = int(random(MIN_RAD, MAX_RAD));
      fill(255, 0, 0, 50);
      stroke(0);
      circle(mouseX, mouseY, rad);
      ol.applyPropulsion(mouseX, mouseY, rad, random(MIN_FORCE, MAX_FORCE));
    }// Propulsion
    ol.run(toggles[bounce], toggles[collision]);
    //println(toggles[collision]);
  }// Moving
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
    rect(3 + m * sectionWidth, 5 + buttonHeight, sectionWidth, buttonHeight, 5); // Rounded corners

    // Draw label centered in each section
    fill(255);
    textAlign(CENTER, CENTER);
    text(label, 3 + m * sectionWidth + sectionWidth/2, 5 + buttonHeight + buttonHeight/2);
  }//end of for loop

  sectionWidth = (width) / sim.length;

  for (int m = 0; m < sim.length; m++) {
    String label = simT[m];

    // Draw button background
    if (sim[m]) {
      fill(76, 175, 80);  // Green when on
      print(m);
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
  }//end of for loop two

  // Below for new list making info
  fill(0);
  textAlign(RIGHT, BOTTOM);
  text("Ordered? " + ordered, width-10, height-20);
  textSize(15);
  text("* o to change ordered, n to make new list", width-10, height-5);
}//modeButtons

void mouseClicked() {
  // Process clicks between y = 5 and y = 35
  if (mouseY >= 5 && mouseY <= 35) {
    // Iterate through toggles
    for (int i = 0; i < sim.length; i++) {
      // Check horizontal position
      if (mouseX < (i + 1) * (width / sim.length)) {
        for(int j = 0; j < sim.length; j++) {
          if(j == i) {
            sim[j] = true;
          }
          else {
            sim[j] = false;
          }
        }

        //println(sim[i]);
        break;
      }
    }
  }
  if (mouseY > 35 && mouseY <= 65) {
    // Iterate through toggles
    for (int i = 0; i < toggles.length; i++) {
      // Check horizontal position
      if (mouseX < (i + 1) * (width / toggles.length)) {
        // Toggle the corresponding boolean
        toggles[i] = !toggles[i];
        //println(sim[i]);
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
  if (key == 'f') toggles[6] = !toggles[6]; // Fall
  if (key == 's') toggles[7] = !toggles[7]; // Springs
  if (key == 'l') toggles[8] = !toggles[8]; // LGrav
  if (key == 'n') ol = new OrbList(NUM_ORBS, ordered); // new List
  if (key == 'o') ordered = !ordered; // Ordered
  if (key == '1') {
    for (int i = 0; i < sim.length; i++) {
      if (i == 0) {
        sim[i] = true;
      } else {
        sim[i] = false;
      }
    }
  } // Orbit
    if (key == '2') {
    for (int i = 0; i < sim.length; i++) {
      if (i == 1) {
        sim[i] = true;
      } else {
        sim[i] = false;
      }
    }
  } // Spring
    if (key == '3') {
    for (int i = 0; i < sim.length; i++) {
      if (i == 2) {
        sim[i] = true;
      } else {
        sim[i] = false;
      }
    }
  } // Drag
    if (key == '4') {
    for (int i = 0; i < sim.length; i++) {
      if (i == 3) {
        sim[i] = true;
      } else {
        sim[i] = false;
      }
    }
  } // Shockwave
    if (key == '5') {
    for (int i = 0; i < sim.length; i++) {
      if (i == 4) {
        sim[i] = true;
      } else {
        sim[i] = false;
      }
    }
  } // Combination
}//keyPressed
