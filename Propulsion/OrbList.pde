class OrbList {

  OrbNode front;

  OrbList(int n, boolean f) {
    front = null;
    populate(n, f);
  }//constructor

  void addFront(OrbNode o) {
    OrbNode olds = front;
    o.next = olds;
    olds.previous = o;
    front = o;
  }//addFront

  void populate(int n, boolean ordered) {
    int i = 0;
    if (ordered) {
      float bs = random(MIN_SIZE, MAX_SIZE);
      front = new OrbNode(5+bs/2, height/2, bs, random(MIN_MASS, MAX_MASS));
      OrbNode current = front;
      while (i < n) {
        current.next = new OrbNode(current.center.x+SPRING_LENGTH, height/2, random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
        current.next.previous = current;
        current = current.next;
        i++;
      }
    } else {
      front = new OrbNode();
      OrbNode current = front;
      while (i < n) {
        current.next = new OrbNode();
        current.next.previous = current;
        current = current.next;
        i++;
      }
    }
  }//populate

  void display(int springLength) {
    OrbNode current = front;
    while (current != null) {
      current.display();
      current = current.next;
    }
    current = front;
    while (current != null) {
      if (toggles[spring]  || sim[1]) {
        current.drawSpring(springLength);
      }
      current = current.next;
    }
  }//display

  void applyForce(PVector force) {
    OrbNode current = front;
    while (current != null) {
      current.applyForce(force);
      current = current.next;
    }
  }//applyForce

  void applySprings(int springLength, float springK) {
    OrbNode current = front;
    while (current != null) {
      current.applySprings(springLength, springK);
      current = current.next;
    }
  }//applySprings

  void applyGravityList(float gConstant) {
    OrbNode current = front;
    OrbNode current2 = front.next;
    while (current != null) {
      while (current2 != null) {
        if (current2 != current) {
          current.applyForce( current.getGravity(current2, gConstant) );
          current2.applyForce( current2.getGravity(current, gConstant) );
        }
        current2 = current2.next;
      }
      current = current.next;
    }
  }//applySprings

  void applyGravity(float gConstant) {
    OrbNode current = front;
    while (current != null) {
      if (current.next != null) {
        current.applyForce( current.getGravity(current.next, gConstant) );
      }
      if (current.previous != null) {
        current.applyForce( current.getGravity(current.previous, gConstant) );
      }
      current = current.next;
    }
  }//applyGravity

  void applyDrag(float dc) {
    OrbNode current = front;
    while (current != null) {
      current.applyForce( current.getDragForce(dc) );
      current = current.next;
    }
  }//applyDrag

  void applyPropulsion(int x, int y, int r, float m) {
    OrbNode current = front;
    while (current != null) {
      current.applyForce( current.getPropulsion(x, y, r, m) );
      if (current.getPropulsion(x, y, r, m).mag() != 0) {
        println(current.getPropulsion(x, y, r, m));
      }
      current = current.next;
    }
  }//applyPropulsion

  void run(boolean bou, boolean coll) {
    boolean reg = true;
    OrbNode current = front;
    OrbNode current2 = front.next;
    if (coll) {
      while (current != null) {
        while (current2 != null) {
          if (current.collisionCheck(current2) && current != current2) {
            current.collision(current2);
            println(current2.velocity);
            reg = false;
            break;
          }
          current2 = current2.next;
        }
        if (reg) {
          current.move(bou);
        }
        current = current.next;
        current2 = front;
      }
    } else {
      while (current != null) {
        current.move(bou);
        current = current.next;
      }
    }
  }//run

  void removeFront() {
    front = front.next;
    front.previous = null;
  }//removeFront

  void removeNode(OrbNode o) {
    OrbNode current = o;
    while (current.next != null) {
      current.next.previous = current.next;
      current = current.next;
    }
    current = null;
  }//removeNode

  void Orbit(FixedOrb o, float gConstant) {
    //OrbNode current = front;
    //while (current != null) {
    //  current.applyForce(current.getGravity(o, gConstant));
    //  current = current.next;
    //}
    OrbNode current = front;
    while (current != null) {
      PVector gravity = current.getGravity(o, gConstant);
      current.applyForce(gravity);
      PVector toCenter = PVector.sub(o.center, current.center);
      float distance = toCenter.mag();
      float orbitalSpeed = (sqrt(gConstant * o.mass / distance)) * 10;
      PVector tangent = new PVector(-toCenter.y, toCenter.x).normalize();
      tangent.mult(orbitalSpeed);

      //sets velocity to the tangent direction
      current.velocity = tangent;
      current = current.next;
    }
  }//Orbit

  void simpleDisplay() {
    OrbNode current = front;
    while (current != null) {
      current.display();
      current = current.next;
    }
  }//simpleDisplay

  void SpringSim(FixedOrb o, int springLength) {
    OrbNode current = front;
    while (current != null) {
      if (round(current.center.dist(o.center)) == springLength) {
        stroke(100);
      } else if (round(current.center.dist(o.center)) < springLength) {
        stroke(100, 255, 100);
      } else {
        stroke(255, 100, 100);
      }
      strokeWeight(1);
      line(current.center.x, current.center.y, o.center.x, o.center.y);
      current = current.next;
    }
  }//SpringSim

  void SpringJester(FixedOrb o, int springLength, float springK) {
    OrbNode current = front;
    while (current != null) {
      current.applyForce(current.getSpring(o, springLength, springK));
      current = current.next;
    }
  }//SpringJester
}//OrbList
