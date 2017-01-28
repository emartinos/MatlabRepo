
function  sA = getCorrectWrongArrayForSize(mySize)
returnMatrix = [];
for i=1 : mySize
    if(i/mySize) > 0.5
    returnMatrix(i,1) = 1;
    else
     returnMatrix(i,1) = -1;
    end
        
end
sA = shuffleD(returnMatrix)
return