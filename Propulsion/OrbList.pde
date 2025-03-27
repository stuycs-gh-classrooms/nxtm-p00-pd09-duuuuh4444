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
      current.drawSpring(springLength);
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

  void applyGravity(Orb other, float gConstant) {
    OrbNode current = front;
    while (current != null) {
      current.applyForce( current.getGravity(other, gConstant) );
      current = current.next;
    }
  }//applySprings


  void run(boolean bou, boolean coll) {
    boolean reg = true;
    OrbNode current = front;
    OrbNode current2 = front.next;
    if (coll) {
      while (current != null) {
        while (current2 != null) {
          if (current.collisionCheck(current2) && current != current2) {
            current.collision(current2);
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
}//OrbList
