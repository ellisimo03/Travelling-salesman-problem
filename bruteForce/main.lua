BUTTON_HEIGHT = 32 -- height of the button is 32 pixels
Cities = {}
OrderOfCities = {}
ShortestPath = {}
NoOfCities = 8
ShortestDistance = 1e309
LatestDistance = 1e309
InitialDistance = 0
NextOrder = true
Timer = 0
InitialTime = 0
TotalTimer =0

function NextPermutation()
    LargestIndex1 = -1
    LargestIndex2 = -1
    NewOrder = {}
    Finished = true
    for i = 1 , NoOfCities - 1 , 1 do
        if OrderOfCities[i] < OrderOfCities[i + 1] then
            LargestIndex1 = i
        end
    end
    if LargestIndex1 == - 1 then
        Finished = false
        return Finished
    end
    for i = 1, NoOfCities, 1 do
        if OrderOfCities[LargestIndex1] < OrderOfCities[i] then
            LargestIndex2 = i
        end
    end
Temp = OrderOfCities[LargestIndex1]
OrderOfCities[LargestIndex1] = OrderOfCities[LargestIndex2]
OrderOfCities[LargestIndex2] = Temp
for i = 1 , LargestIndex1 do
    NewOrder[i] = OrderOfCities[i]
    
end
for i = LargestIndex1+1, NoOfCities do
    NewOrder[i] = OrderOfCities[(NoOfCities-(i-LargestIndex1))+1]
end
--for i =1 , NoOfCities do
    --OrderOfCities[i] = NewOrder[i]
--end
OrderOfCities = NewOrder
return Finished
end


function Calcdistance()
    Sum = 0
    for i = 1 , NoOfCities -1 do
        CityAIndex = OrderOfCities[i]
        CityBIndex = OrderOfCities[i+1]
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

function love.load ()
    local screen_width, screen_height = love.graphics.getDimensions()
    InitialTime = love.timer.getTime()
for i=1,NoOfCities do
  Cities[i] = {}
end
for i = 1,NoOfCities, 1 do
    Cities[i][1] = love.math.random(10,screen_width-5)     
    Cities[i][2] = love.math.random(10,500)
    OrderOfCities[i] = i
    ShortestPath[i] = i
end
ShortestDistance = Calcdistance()
InitialDistance = ShortestDistance
end


function love.update(dt)
--while NextOrder do
 NextOrder = NextPermutation()
 LatestDistance = Calcdistance()
 if LatestDistance < ShortestDistance then
    --for i = 1 , NoOfCities,1 do
      --  ShortestPath[i] = OrderOfCities[i]
    --end
    ShortestPath = OrderOfCities
    ShortestDistance = LatestDistance
    Timer = love.timer.getTime() - InitialTime
 end
if NextOrder then
    TotalTimer= love.timer.getTime() - InitialTime
end
end
--end
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
       local textWidth = font:getWidth("Shortest Distance: ")
       local textHeight = font:getHeight("Shortest Distance: ")
      
       love.graphics.print("Shortest Distance: ", 
           font,
           button1X ,
           button1Y + (textHeight * 0.5)
           )
           local truncateShortestDistance = math.floor(ShortestDistance*1000)/1000
       love.graphics.print(tostring(truncateShortestDistance), --converts the number into a string
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
       local textWidth = font:getWidth("Initial Distance: ")
       local textHeight = font:getHeight("Initial Distance: ")
      
       love.graphics.print("Initial Distance: ", --I don't know if this is correct ! I want the first element in the table
           font,
           button3X ,
           button3Y + (textHeight * 0.5)
           )
           local truncateInitialDistance = math.floor(InitialDistance*1000)/1000
       love.graphics.print(tostring(truncateInitialDistance), --converts the number into a string
           font,
           button3X + textWidth,
           button3Y + (textHeight * 0.5)
           )
   
           
           -- improving and timer buttons

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
       local textWidth = font:getWidth("PERMUTATING: ")
       local textHeight = font:getHeight("PERMUTATING: ")
      
       love.graphics.print("PERMUTATING: ", 
           font,
           button4X ,
           button4Y + (textHeight * 0.5)
           )
           
           TotalTimer = math.floor(TotalTimer*1000)/1000
       love.graphics.print(tostring(NextOrder).." "..TotalTimer,
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
       local tempCity1 = ShortestPath[i]
       local tempCity2 = ShortestPath[i+1]
    local x1 = Cities[tempCity1][1]
     local y1 = Cities[tempCity1][2]
     local x2 = Cities[tempCity2][1]
     local y2 = Cities[tempCity2][2]
    love.graphics.line(x1, y1, x2, y2 )
   end
   
   end