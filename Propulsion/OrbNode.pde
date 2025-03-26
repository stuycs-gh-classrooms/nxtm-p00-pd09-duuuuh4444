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

  void move(boolean bounce, boolean coll) {
    boolean reg = false;
    if (bounce) {
      xBounce();
      yBounce();
    }

    if (coll) {
      if (next != null) {
        if (center.dist(next.center) < bsize/2+next.bsize/2) {
          reg = true;
          velocity.mult(-1);
          center.add(velocity);
          next.velocity.mult(-1);
          next.center.add(next.velocity);
          acceleration.mult(0);
          next.acceleration.mult(0);
        }
      }
      if (previous != null) {
        if (center.dist(previous.center) < bsize/2+previous.bsize/2) {
          reg = true;
          velocity.mult(-1);
          center.add(velocity);
          previous.velocity.mult(-1);
          previous.center.add(previous.velocity);
          acceleration.mult(0);
          previous.acceleration.mult(0);
        }
      }
      if (!reg) {
        velocity.add(acceleration);
        center.add(velocity);
        acceleration.mult(0);
      }
    } else {
      velocity.add(acceleration);
      center.add(velocity);
      acceleration.mult(0);
    }
  }//move
}//OrbNode
