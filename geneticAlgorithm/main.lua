BUTTON_HEIGHT = 32 -- height of the button is 64 pixels
Cities = {}
OrderOfCities = {}
NoOfCities = 10
ShortestPath = {}
ShortestDistance = 1e309
NextOrder = {}
PopulationSize = 1000
Population = {}
Fitness = {}
ShortestPathEver = {}
ShortestPathNow = {}
MutationIndex = 0.1
Improving = true
InitialDistance = 0
Timer = 0
InitialTime = 0
TotalTimer =0
NoOfGenerationsWithoutImprovement =0
TotalGenerationsWithoutImprovement =500
math.randomseed(os.time())


local font = nil
function Mutation(NewOrder)
    local City1
    local City2
    local temp 
    for i = 1 , NoOfCities do
        local DoMutation = math.random()
        if DoMutation < MutationIndex then
            City1 = math.random(NoOfCities)
            if City1 == NoOfCities then
                City2 = 1
            else City2 = City1 + 1
            end
         temp = NewOrder[City1]
         NewOrder[City1] = NewOrder[City2]
         NewOrder[City2] = temp
        end 
         
    end
    
    return NewOrder
end
function Calcdistance(Order)
    local Sum = 0
    local CityAIndex
    local CityBIndex
    local CityAX
    local CityAY
    local CityBX
    local CityBY
    local X
    local Y
    local DistanceCityACityB

    for i = 1 , NoOfCities - 1 do
        CityAIndex = Order[i]
        CityBIndex = Order[i+1]
        
        CityAX = Cities[CityAIndex][1]
        CityAY = Cities[CityAIndex][2]
        CityBX = Cities[CityBIndex][1]
        CityBY = Cities[CityBIndex][2]
        if CityAX > CityBX then
            X = CityAX - CityBX
        else
            X = CityBX - CityAX
        end
        if CityAY > CityBY then
            Y = CityAY - CityBY
        else
            Y = CityBY - CityAY
        end
        DistanceCityACityB = math.sqrt((X*X)+(Y*Y))
        Sum = Sum + DistanceCityACityB
    end
    return Sum
end

function SelectBest()
    local Index = 1
    local R = math.random()
    local OrderPicked = {}
    
    while R > 0 do
        R = R - Fitness[Index]
        Index = Index + 1
    end
    Index = Index - 1
    
    for i = 1 , NoOfCities do
        OrderPicked[i] = Population[Index][i]
    end
    
    return OrderPicked
end

function Crossover(Order1,Order2)
    local NewOrder = {}
    local NextIndex = 1
    local City 
    local Counter
    local Notfound = true
    
    local start = math.random(NoOfCities)
    if start == NoOfCities then
        start = start -1
    end
    local TempEnding = NoOfCities - start
    local ending = math.random(TempEnding)+ start
    
    for i = start , ending do
        NewOrder[NextIndex] = Order1[i]
        NextIndex = NextIndex + 1
    end
    local Order1End = NextIndex - 1
    for i = 1 , NoOfCities do
        City = Order2[i]
        Counter = 0 
        Notfound = true
        while Counter <= Order1End and Notfound do
            if NewOrder[Counter] == City then
                Notfound = false
            end
            Counter = Counter + 1 
        end
        if Notfound then
            NewOrder[NextIndex] = City
            NextIndex = NextIndex + 1
        end
    end
    
    return NewOrder
end

function FisherYatesShuffle(Items)
local NewItems = {}
local TempIndex = {}
local Index = 0
for i = 1 , NoOfCities do
    TempIndex[i] = 0
end
for i = 1 , NoOfCities do
    repeat
        Index = math.random(NoOfCities)
    until (TempIndex[Index] == 0)
    TempIndex[Index] = 1
    NewItems[i] = Items[Index]
end

    return NewItems
end

function CalcFitness()
    local Order = {}
    local ShortestDistanceBefore = ShortestDistance
    for i = 1 , PopulationSize do
        for j = 1 , NoOfCities do
            Order[j] = Population[i][j]

        end
        local Distance = Calcdistance(Order)
      
        if Distance< ShortestDistance then
            for k = 1 , NoOfCities do
                ShortestPathEver[k] = Order[k]
            end
            ShortestDistance = Distance
            Timer = love.timer.getTime() - InitialTime
        end
        Fitness[i] = 1/(Distance+1)
        
    end
    if ShortestDistanceBefore <= ShortestDistance then
            NoOfGenerationsWithoutImprovement = NoOfGenerationsWithoutImprovement + 1
            if NoOfGenerationsWithoutImprovement == TotalGenerationsWithoutImprovement then
                Improving = false
            end
        else
            NoOfGenerationsWithoutImprovement = 0
        end
   
  
        
end
function NormalizeFitness()
    local Sum = 0 
    for i = 1 , PopulationSize do
        Sum = Sum + Fitness[i]

    end
    for i = 1 , PopulationSize do
        Fitness[i] = Fitness[i]/ Sum
    end
    
end

function NextGeneration()
    local NewPopulation = {}
    local Order1 = {}
    local Order2 = {}
    local NewOrder = {}

    for i = 1 , PopulationSize do
        NewPopulation[i]={}
    end
    for i = 1 , PopulationSize do
        Order1 = SelectBest()
        Order2 = SelectBest()
        NewOrder = Crossover(Order1 , Order2)
        for k = 1 , NoOfCities do
          
        end
        NewOrder = Mutation(NewOrder)
        for k = 1 , NoOfCities do
            
        end
        for j = 1 , NoOfCities do
            NewPopulation[i][j] = NewOrder[j]
        end
    end
    Population = NewPopulation --Might need loops
end


function love.load()
   InitialTime = love.timer.getTime()
    for i=1,NoOfCities do

       Cities[i] = {}
        
       end
       local screen_width, screen_height = love.graphics.getDimensions()
        
        for i = 1,NoOfCities do
        
        Cities[i][1] = love.math.random(10,screen_width-5)
        
        Cities[i][2] = love.math.random(10,500)

        OrderOfCities[i] = i
        ShortestPath[i] = i
        end
        InitialDistance = Calcdistance(OrderOfCities)
        for i = 1 , PopulationSize do
            Population[i] = {}
        end
        for i = 1 , PopulationSize do
            NextOrder = FisherYatesShuffle(OrderOfCities)
            
            for j = 1 , NoOfCities do
                Population[i][j] = NextOrder[j]
            end
        end
        
        CalcFitness()
end

function love.update(dt)
    --if Improving then
        NormalizeFitness()
        NextGeneration()
        CalcFitness()
        if Improving then
            TotalTimer= love.timer.getTime() - InitialTime
        end
   -- end
end

function love.draw()
 local window_width = love.graphics.getWidth()
 local window_height = love.graphics.getHeight()
 local button1_width = window_width * (1/3)
 local button1X =  (window_width*0.25) - (button1_width * 0.5)
 local button1Y =  (window_height*0.90) - (BUTTON_HEIGHT * 0.5)

   love.graphics.setColor(0.4, 0.4, 0.5, 1.0)
   love.graphics.rectangle(
          "fill",
	button1X ,
	button1Y,
	  button1_width,
          BUTTON_HEIGHT
	)
    font = love.graphics.newFont(16)
    love.graphics.setColor(0, 0, 0, 1) --set color to black for the text
    local textWidth = font:getWidth(" Shortest Distance: ")
    local textHeight = font:getHeight(" Shortest Distance: ")
   
    love.graphics.print(" Shortest Distance: ", 
		font,
		button1X ,
		button1Y + (textHeight * 0.5)
		)
        ShortestDistance = math.floor(ShortestDistance*1000)/1000
    love.graphics.print(tostring(ShortestDistance), --converts the number into a string
		font,
		button1X + textWidth,
		button1Y + (textHeight * 0.5)
		)
-- initial distance
local window_width = love.graphics.getWidth()
 local window_height = love.graphics.getHeight()
 local button3_width = window_width * (1/3)
 local button3X =  (window_width*0.25) - (button3_width * 0.5)
 local button3Y =  (window_height*0.95) - (BUTTON_HEIGHT * 0.5)

   love.graphics.setColor(0.4, 0.4, 0.5, 1.0)
   love.graphics.rectangle(
          "fill",
	button3X ,
	button3Y,
	  button3_width,
          BUTTON_HEIGHT
	)
    font = love.graphics.newFont(16)
    love.graphics.setColor(0, 0, 0, 1) --set color to black for the text
    local textWidth = font:getWidth(" Initial Distance: ")
    local textHeight = font:getHeight(" Initial Distance: ")
   
    love.graphics.print(" Initial Distance: ", --I don't know if this is correct ! I want the first element in the table
		font,
		button3X ,
		button3Y + (textHeight * 0.5)
		)
        InitialDistance = math.floor(InitialDistance*1000)/1000
    love.graphics.print(tostring(InitialDistance), --converts the number into a string
		font,
		button3X + textWidth,
		button3Y + (textHeight * 0.5)
		)
-- improving and timer


local button4_width = window_width * (1/3)
local button4X =  (window_width*0.6) - (button1_width * 0.5)
local button4Y =  (window_height*0.90) - (BUTTON_HEIGHT * 0.5)

  love.graphics.setColor(0.4, 0.4, 0.5, 1.0)
  love.graphics.rectangle(
         "fill",
   button4X ,
   button4Y,
     button4_width,
         BUTTON_HEIGHT
   )
   font = love.graphics.newFont(16)
   love.graphics.setColor(0, 0, 0, 1) --set color to black for the text
   local textWidth = font:getWidth(" IMPROVING: ")
   local textHeight = font:getHeight(" IMPROVING: ")
  
   love.graphics.print(" IMPROVING: ", 
       font,
       button4X ,
       button4Y + (textHeight * 0.5)
       )
       
       TotalTimer = math.floor(TotalTimer*1000)/1000
   love.graphics.print(tostring(Improving)..", "..TotalTimer,
       font,
       button4X + textWidth,
       button4Y + (textHeight * 0.5)
       )
-- Time 
local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local button5_width = window_width * (1/3)
local button5X =  (window_width*0.6) - (button5_width * 0.5)
local button5Y =  (window_height*0.95) - (BUTTON_HEIGHT * 0.5)

  love.graphics.setColor(0.4, 0.4, 0.5, 1.0)
  love.graphics.rectangle(
         "fill",
   button5X ,
   button5Y,
     button5_width,
         BUTTON_HEIGHT
   )
   font = love.graphics.newFont(16)
   love.graphics.setColor(0, 0, 0, 1) --set color to black for the text
   local textWidth = font:getWidth("TIME: ")
   local textHeight = font:getHeight("TIME: ")
  
   love.graphics.print("TIME: ", --I don't know if this is correct ! I want the first element in the table
       font,
       button5X ,
       button5Y + (textHeight * 0.5)
       )
       local truncateTimer= math.floor(Timer*1000)/1000
   love.graphics.print(tostring(truncateTimer), --converts the number into a string
       font,
       button5X + textWidth,
       button5Y + (textHeight * 0.5)
       )
 --need to do Exit button
 font = love.graphics.newFont(32)
 local last = false
 local now = false
 local button2_width =  window_width * (1/7)
 local button2X = (window_width*0.875) - (button2_width * 0.5)
 local button2Y = (window_height*0.90) - (BUTTON_HEIGHT * 0.5)
 local color = {0.4, 0.4, 0.5, 1.0}
 local mouseX, mouseY = love.mouse.getPosition()
 local hot = mouseX > button2X and mouseX < button2X + button2_width and
	     mouseY > button2Y and mouseY < button2Y + BUTTON_HEIGHT
 last = now 
 

 if hot then
	color = {0.8, 0.8, 0.9, 1.0}
 end
now = love.mouse.isDown(1)
if now and not last and hot then
    love.event.quit(0)
end

   love.graphics.setColor(unpack(color))
   love.graphics.rectangle(
          "fill",
	button2X ,
	button2Y,
	  button2_width,
          BUTTON_HEIGHT
	)
    love.graphics.setColor(0, 0, 0, 1) --set color to black for the text
    local textWidth = font:getWidth("Exit")
    local textHeight = font:getHeight("Exit")
    
    love.graphics.print("Exit", --I don't know if this is correct ! I want the second element in the table
		font,
		button2X + (textWidth *0.5),
		button2Y 
		)

--write a rectangle to draw the cities in
love.graphics.setColor(1,0,0)
love.graphics.rectangle("line",5,10,790,500)

love.graphics.setPointSize(8)
    
love.graphics.points(Cities)
love.graphics.setColor(255,255,255)
love.graphics.setLineWidth(0.5)
for i=1, NoOfCities-1 do
    local tempCity1 = ShortestPathEver[i]
    local tempCity2 = ShortestPathEver[i+1]
 local x1 = Cities[tempCity1][1]
  local y1 = Cities[tempCity1][2]
  local x2 = Cities[tempCity2][1]
  local y2 = Cities[tempCity2][2]
 love.graphics.line(x1, y1, x2, y2 )
end

end