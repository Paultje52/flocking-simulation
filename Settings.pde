// Here are all the settings for the simulation

// How many boids there should be
int boidsSize = 100;


// The magnitudes
float CohesionMagnitude = 1; // Cohesion (Towards other boids)
float SeparationMagnitude = 0.9; // Separation (Away from other boids)
float AlignmentMagnitude = 0.8; // Alignment (Same direction as other boids)


// How far do boids need to check for other boids?
// This is in "blocks", when the size is 30, each block is 30x30 pixels. Each boid is 5x5 pixels
int neighborsRange = 2;


// The force to randomize a boid's position
float randomForce = 1;


// The update UPS (Updates Per Second). If this is heigher, the simulation is faster.
int fps = 60;


// What is the max speed the boid should travel?
float maxBoidSpeed = 5;
