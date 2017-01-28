
function  colorAndPos = getCorrectRandomColorAndPositionFromVector(vector)
yPos = randi((size(vector,1)),1,1);
xPos = randi((size(vector,2)),1,1);

while vector(yPos,xPos) == 0
    yPos = randi((size(vector,1)),1,1);
    xPos = randi((size(vector,2)),1,1);
end

colorAndPos(1,1) = yPos;
colorAndPos(1,2) = xPos;
colorAndPos(1,3) = vector(yPos,xPos);
colorAndPos(1,4) = 1;
return