%returns y , x values that should show on screen and the actual value and
%whether its correct or not.
function  colorAndPos = getFalseRandomColorAndPositionFromVector(vector)
yPos = randi((size(vector,1)),1,1);
xPos = randi((size(vector,2)),1,1);

while vector(yPos,xPos) == 0
    yPos = randi((size(vector,1)),1,1);
    xPos = randi((size(vector,2)),1,1);
end

colorAndPos(1,1) = yPos;
colorAndPos(1,2) = xPos;

correctColor = vector(yPos,xPos);
returnedColor = randi(9);
while returnedColor == correctColor
    returnedColor = randi(9);
end
colorAndPos(1,3) = returnedColor;
colorAndPos(1,4) = -1;
return