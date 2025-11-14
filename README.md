# Travelling-salesman-problem
Here, I tackle the travelling salesman problem (TSP). I have written it in Lua and used LÖVE as the GUI. I compare 2 methods - brute force and optimization using evolutionary algorithms.
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

First of all, I need to populate

This  function prepares possibilities for selection:
```lua
NormalizeFitness()
```
