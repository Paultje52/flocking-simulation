class Space {
  public ArrayList<Boid> boids = new ArrayList<Boid>(); // An array with all the boids
  private Cell[][] cells; // The array for the location of the boids (cells[x][y].boids)
  private int size; // The size of the space

  Space(int size) {
    this.size = size;
    this.cells = new Cell[size][size];
    // Make all the cells instances and add them
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        this.cells[x][y] = new Cell(x, y, size);
      }
    }
  }

  // Update a boid's location in the cells
  public void update(Boid boid) {
    if (!this.boids.contains(boid)) this.boids.add(boid); // Add the boid to the list
    this.cells[boid.cellX][boid.cellY].boids.remove(boid); // Remove the boid from the previous place
    boid.cellX = (int) (boid.x/this.size); // Calculate the cellX from the boid's position
    if (boid.cellX >= this.size) boid.cellX = this.size-1; // Make sure we don't get an ArrayIndexOutOfBoundsException
    boid.cellY = (int) (boid.y/this.size); // Calculate the cellY from the boid's position
    if (boid.cellY >= this.size) boid.cellY = this.size-1; // Make sure we don't get an ArrayIndexOutOfBoundsException
    this.cells[boid.cellX][boid.cellY].boids.add(boid); // Add the boid to it's new cell
  }

  // Get all the boids from a specific cell
  public ArrayList<Boid> getFromCell(int x, int y) {
    ArrayList<Boid> boids = new ArrayList<Boid>();
    Object[] cellData = this.cells[x][y].boids.toArray();
    for (Object boid : cellData) {
      boids.add((Boid) boid);
    }
    return boids;
  }

  // Get the boid's neighbors with a radius
  public ArrayList<Boid> getNeighbors(Boid boid, int radius) {
    radius++; // I know, this is a janky solution, but it works
    ArrayList<Boid> boids = new ArrayList<Boid>();

    // First, the X radius.
    for (int x = -radius+1; x < radius; x++) {
      //if (x < 0) continue; // If x is less than 0, don't do it.
      int cellX = boid.cellX+x;

      // Looking on the other side.
      if (cellX >= this.size) cellX = 0+cellX-this.size;
      if (cellX < 0) cellX = this.size-cellX;

      // Now, loop for the Y cells in the X row
      for (int y = -radius+1; y < radius; y++) {
        //if (y < 0) continue; // If y is less than 0, don't do it.
        int cellY = boid.cellY+y;

        // Looking on the other side
        if (cellY >= this.size) cellY = 0+cellY-this.size;
        if (cellY < 0) cellY = this.size-cellY;


        // Catch ArrayIndexOutOfBoundsException
        if (cellX > this.size) cellX = this.size-1;
        if (cellY > this.size) cellY = this.size-1;
        if (cellX < 0) cellX = 0;
        if (cellY < 0) cellY = 0;
        // Get all the boids in this cell
        Object[] boidsInCell = this.cells[cellX][cellY].draw().boids.toArray();
        // Add the boids to list if they aren't in it yet.
        for (Object b : boidsInCell) {
          Boid boidInCell = (Boid) b;
          boolean exists = boid.id == boidInCell.id;
          for (Boid bo : boids) {
            if (bo.id == boidInCell.id) exists = true;
          }
          if (exists) continue;
          boids.add(boidInCell);
        }
      }
    }
    return boids;
  }
}

// For each cell, you get a cell class, which you can find here.
class Cell {
  public ArrayList<Boid> boids = new ArrayList<Boid>(); // All the boids in the cell

  public int x; // Cell X
  public int y; // Cell Y
  public int size; // Size of cell

  // Creating the cell
  // Want to visualy see the cells?
  // Uncomment line 100, 105 and 106
  Cell(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
    //this.draw();
  }

  // Drawing a rectangle so you can see there the cells are
  public Cell draw() {
    //new rectangle(this.size, this.size).setPosition(this.x*this.size, this.y*this.size)
    //    .setColor(255, 255, 255);
    return this;
  }
}
