// The boid, where all the magic happens.
class Boid {
  // Initialize variables
  public float x;
  public float y;
  public int id;
  
  public int cellX = 0;
  public int cellY = 0;
  
  private rectangle rec = new rectangle(5, 5);
  private Space space;
  public PVector position; // Other boids need this for the separation and cohesion
  public PVector acceleration; // Other boids need this for the alignment
  
  
  // Make the boid and draw it
  Boid(int id, Space space, float startingX, float startingY) {
    this.id = id;
    this.x = startingX;
    this.y = startingY;
    this.space = space;
    this.draw();
    this.space.update(this);
    
    // Update the position and acceleration vectors
    this.position = new PVector(this.x, this.y);
    this.acceleration = new PVector(random(-3, 3), random(-3, 3));
  }
  
  
  // For each frame, calculate the cohesion, separation and alignment and combine the PVectors to move!
  public void update() {
    ArrayList<Boid> neighbors = this.space.getNeighbors(this, neighborsRange); // Get all the neighbors
    
    // Calculate the vector
    PVector cohesion = PVector.mult(this.getCohesion(neighbors), CohesionMagnitude); // Get the cohesion and add the magnitude
    PVector separation = PVector.mult(this.getSeparation(neighbors), SeparationMagnitude); // Get the separation and add the magnitude
    PVector alignment = PVector.mult(this.getAlignment(neighbors), AlignmentMagnitude); // Get the alignment and add the magnitude
    
    // Cobine the vectors
    PVector randomize = new PVector(random(-1 * randomForce, randomForce), random(-1 * randomForce, randomForce));
    this.acceleration = PVector.add(cohesion, PVector.add(separation, alignment));
    this.acceleration = PVector.add(acceleration, randomize);
    this.acceleration.set(this.speedCap(this.acceleration.x, maxBoidSpeed), this.speedCap(this.acceleration.y, maxBoidSpeed));
    // If there isn't any acceleration, the boids start to fly randomly until there is an acceleration
    if (this.acceleration.x == 0 && this.acceleration.y == 0) this.acceleration = new PVector(random(-3, 3), random(-3, 3));
    this.position = PVector.add(this.position, this.acceleration);
    
    
    // Make sure the boid doesn't go in the nothingness
    this.position.set(
      this.wrapAround(this.position.x, 0, 900),
      this.wrapAround(this.position.y, 0, 900)
    );
    
    // Update positions on the screen and in the space
    this.x = this.position.x;
    this.y = this.position.y;
    this.draw();
    this.space.update(this);
  }
  
  // Util stuff
  private float wrapAround(float position, float min, float max) { // To be sure the boid isn't going into the nothingness
    if (position <= min) return max;
    else if (position >= max) return min;
    return position;
  }
  private float speedCap(float result, float max) { // To be sure the boid isn't going too fast
    if (result > max) result = max;
    return result;
  }
  
  
  // Get the cohesion. Each boid wants to stay at other boids.
  // The boid wants to move to the center of the other boids
  private PVector getCohesion(ArrayList<Boid> neighbors) { // Change the cohesion magnitude in the settings
    PVector result = new PVector();
    // If there aren't any boids, return an empty Verctor
    if (neighbors.size() == 0) return result;
    
    for (Boid neighbor : neighbors) {
      // For each neighbor, add the position
      result = PVector.add(result, neighbor.position); 
    }
    result = PVector.div(result, neighbors.size()); // Get the avarage/center position of the other boids   
    
    // Return the result with the new Vector
    return PVector.sub(result, this.position).normalize();
  }
  
  
  // Get the separation. Each boid needs to avoid eachother.
  // The boids want to avoid collisions.
  private PVector getSeparation(ArrayList<Boid> neighbors) { // Change the separation magnitude in the settings
    PVector result = new PVector();
    // If there aren't any boids, return an empty Verctor
    if (neighbors.size() == 0) return result;
    
    for (Boid neighbor : neighbors) {
      // For each neighbor, get the space between him and me and divide
      PVector toMe = PVector.sub(this.position, neighbor.position);
      if (toMe.mag() > 0) { // If the boids wants to go there, go away
        PVector devided = PVector.div(toMe.normalize(), toMe.mag());
        result = PVector.add(result, devided);
      }
    }
    
    // Return the result with the new Vector
    return result.normalize();
  }
  
  
  // Finaly, the alignment. The boid wants to fly in the same direction as other boids
  // With this, the boids try to fly in a "group".
  private PVector getAlignment(ArrayList<Boid> neighbors) { // Change the alignment magnitude in the settings
    PVector result = new PVector();
    // If there aren't any boids, return an empty Verctor
    if (neighbors.size() == 0) return result;
    
    for (Boid neighbor : neighbors) {
      // For each neighbore, get the acceleration and add this to the alignment
      result = PVector.add(result, neighbor.acceleration);
    }
    
    // Return the result with the new Vector
    return result.normalize();
  }
  
  
  // Draw the rectangle position.
  private void draw() {
    rec.setPosition(this.x-2.5, this.y-2.5);
  }
}
