/*

    ███████╗██╗░░░░░░█████╗░░█████╗░██╗░░██╗██╗███╗░░██╗░██████╗░
    ██╔════╝██║░░░░░██╔══██╗██╔══██╗██║░██╔╝██║████╗░██║██╔════╝░
    █████╗░░██║░░░░░██║░░██║██║░░╚═╝█████═╝░██║██╔██╗██║██║░░██╗░
    ██╔══╝░░██║░░░░░██║░░██║██║░░██╗██╔═██╗░██║██║╚████║██║░░╚██╗
    ██║░░░░░███████╗╚█████╔╝╚█████╔╝██║░╚██╗██║██║░╚███║╚██████╔╝
    ╚═╝░░░░░╚══════╝░╚════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░╚══╝░╚═════╝░
    
    ░██████╗██╗███╗░░░███╗██╗░░░██╗██╗░░░░░░█████╗░████████╗██╗░█████╗░███╗░░██╗
    ██╔════╝██║████╗░████║██║░░░██║██║░░░░░██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
    ╚█████╗░██║██╔████╔██║██║░░░██║██║░░░░░███████║░░░██║░░░██║██║░░██║██╔██╗██║
    ░╚═══██╗██║██║╚██╔╝██║██║░░░██║██║░░░░░██╔══██║░░░██║░░░██║██║░░██║██║╚████║
    ██████╔╝██║██║░╚═╝░██║╚██████╔╝███████╗██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
    ╚═════╝░╚═╝╚═╝░░░░░╚═╝░╚═════╝░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝
    By: Paultje52
    Github: https://github.com/Paultje52
    
Settings: View "settings.pde"
Boids: View "boid.pde"
Making Rectangles: View "rectangle.pde"
Spacing and cell class: View "space.pde"

*/

Space space;
void setup() {
  space = new Space(30); // 30X30
  size(900, 900); // 900/25 = 25
  // The space is an array of 30X30, <X/Y>/30 can't be more than 30.
  
  frameRate(fps);
  
  for (int i = 0; i < boidsSize; i++) {
    // The boid position is the same as the window size.
    // The X or Y of the boid can't be more than 30.
    new Boid(i, // The boid ID, used to check for neighbors 
             space, // The space where the boid is in
             random(0, 900), // Starting X
             random(0, 900) // Starting Y
    ).update(); 
    // The boid takes care of everything for us, like adding it to the space!
  }
}

void draw() {
  // Update all the boids
  for (int i = 0; i < boidsSize; i++) {
    Boid boid = (Boid) space.boids.toArray()[i];
    boid.update();
  }
}
