# Travelling-salesman-problem
Here, I tackle the travelling salesman problem (TSP). I have written it in Lua and used LÖVE as the GUI. I compare 2 methods - brute force and optimization using evolutionary algorithms.
You can change the variable "NoOfCities" to however many cities you wish to experiment on.
# How to run on linux
Step 1
- Git clone the repository:
```linux 
git clone https://github.com/ellisimo03/Travelling-salesman-problem.git
```
Step 2 
- Install LÖVE in order to run it
```linux 
sudo apt install love
```
Step 3 
- Run the genetic algorithm in the Travelling-salesman-problem directory
```linux 
love geneticAlgorithm
```

# How it works
Here I will explain how the algorithm works in a clear and straighforward way so you can learn, understand and potentially implement the algorithm in your own way!


Population:
- I start off by selecting the population size
- - This can range quite a bit depending on how large or diverse you want your search to be
- Each member of the population has a unique route - their DNA
- - you initialize the population size with loads of different and random solutions to the problem (TSP in this case)


Fitness:
- In the fitness function, you use this to decide which members or "parents" of the population to discard and to keep
- Naturally, you want to keep the members with the best results for your specific scenario
- In this scenario I choose the members with the lowest route cost
- This idea is based off Charles Darwin's  theory of "survival of the fittest"
- The better the solution, the higher the chance of being selected to reproduce.


Crossover:
- Here, you take the best members (parents) from the population (which you chose in the fitness fuction) and "breed" them to create new "offspring"
- You take two members' DNA and combine them
- - The idea is that you take parts of one parent member which you like and combine it with the parts of another parent member which you like as well
- I then randomly take each part of the parents DNA and combine them, repeating this process until it no longer improves
- - This is the "crossover"
 
Mutation:
Why is this important? Well to put it simply, say you have a population who are trying to navigate an obstacle course. They can go forwards, backwards and can jump. If neither parent has the "jumping gene" then it will never get passed onto the offspring. This may make completing the obstacle course impossible. Now mutation comes into play by potentially mutating and allowing the jumping gene to get passed on. In our context:

-  The Mutation randomly changes parts of a route
-  This will stop the algorithm from getting stuck
-  It also allows the population to be more diverse and also adaptable 
