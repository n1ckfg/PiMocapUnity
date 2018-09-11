ArrayList<AutoDot> dots;
int numDots = 5;
float birthOdds = 0.02;
boolean death = false;
boolean birth = false;

void setup() {
  size(640, 480, P3D);
  oscSetup();
  
  dots = new ArrayList<AutoDot>();
  for (int i=0; i<numDots; i++) {
    dots.add(new AutoDot());
  }
}

void draw() {
  background(0);

  for (int i=0; i<dots.size(); i++) {
    AutoDot dot = dots.get(i);
    dot.run();
    if (death && !dot.alive) dots.remove(i);
  }
  
  if (birth && random(1.0) < birthOdds) dots.add(new AutoDot());
}
