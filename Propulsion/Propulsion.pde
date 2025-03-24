int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH;
float  SPRING_K = 0.005;

OrbList ol;

void setup() {
  size(800, 800);
  SPRING_LENGTH = (width-10)/(NUM_ORBS+1);
  ol = new OrbList();
  ol.populate(NUM_ORBS, true);
  println(SPRING_LENGTH);
}

void draw() {
  background(255);
  ol.display(SPRING_LENGTH);
}
