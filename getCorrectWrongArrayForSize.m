
%%This method is used to generate all tests for the square experiment. 1st
%%column is the Y pos, 2nd col is the Y pos, 3rd is the colour(1-6) and 4th
%%is whether the colour is corerct based on the original image shown to the
%%user.
function  myMatrix = getCorrectWrongArrayForSize(mySize)
myMatrix = [];
for i=1 : mySize
    if(i/mySize) > 0.5
    myMatrix(i,1) = 1;
    else
     myMatrix(i,1) = -1;
    end   
end
myMatrix = shuffleD(myMatrix)

%
%returnedMatrix = [];
%for i=1 : mySize
    %%if this sample is correct then return one correct value from square
    %%array
%    if(myMatrix(i,1)) == 1
%        returnedM = getCorrectRandomColorAndPositionFromVector(myVector);
%        returnedMatrix(i,:) = returnedM(1,:);
%    else
    %%if not then return false sample
%    returnedM = getFalseRandomColorAndPositionFromVector(myVector);
%    returnedMatrix(i,:) = returnedM(1,:);
%    end
%end
return