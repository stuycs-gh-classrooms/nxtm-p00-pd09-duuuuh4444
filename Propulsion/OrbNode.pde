class OrbNode extends Orb {

  OrbNode next;
  OrbNode previous;

  OrbNode() {
    next = previous = null;
  }//default constructor
  OrbNode(float x, float y, float s, float m) {
    super(x, y, s, m);
    next = previous = null;
  }//constructor

  void display() {
    super.display();
  }

  void drawSpring(int springLength)
  {
    if (next != null) {
      if (round(center.dist(next.center)) == springLength) {
        //println(round(center.dist(next.center)));
        stroke(0);
      } else if (round(center.dist(next.center)) < springLength) {
        //println(round(center.dist(next.center)));
        stroke(0, 255, 0);
      } else {
        //println(round(center.dist(next.center)));
        stroke(255, 0, 0);
      }
      strokeWeight(1);
      line(center.x, center.y-1, next.center.x, next.center.y-1);
    }
    if (previous != null) {
      if (round(center.dist(previous.center)) == springLength) {
        //println(round(center.dist(previous.center)));
        stroke(0);
      } else if (round(center.dist(previous.center)) < springLength) {
        //println(round(center.dist(previous.center)));
        stroke(0, 255, 0);
      } else {
        //println(round(center.dist(previous.center)));
        stroke(255, 0, 0);
      }
      strokeWeight(1);
      line(center.x, center.y+1, previous.center.x, previous.center.y+1);
    }
  }//drawSpring

  void applySprings(int springLength, float springK) {
    if (next != null) {
      PVector sforce = getSpring(next, springLength, springK);
      applyForce(sforce);
    }
    if (previous != null) {
      PVector sforce = getSpring(previous, springLength, springK);
      applyForce(sforce);
    }
  }///applySprings
}//OrbNode
