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

  void display(int springLength) {
    super.display();
    if (next != null) {
      drawSpring(next, false, springLength);
    }
    if (previous != null) {
      drawSpring(previous, true, springLength);
    }
  }

  void drawSpring(Orb o1, boolean offset, int springLength)
  {
    if (round(center.dist(o1.center)) == springLength) {
      stroke(0);
    } else if (round(center.dist(o1.center)) < springLength) {
      // println(round(center.dist(o1.center)));
      stroke(0, 255, 0);
    } else {
      //println(round(center.dist(o1.center)));
      stroke(255, 0, 0);
    }
    strokeWeight(2);
    if (offset) {
      line(center.x, center.y+10, o1.center.x, o1.center.y+10);
    } else {
      line(center.x, center.y, o1.center.x, o1.center.y);
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
