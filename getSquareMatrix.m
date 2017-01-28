function sA = getSquareMatrix(size)
array = [];

colorPerm = randperm(9,size);
for i = 1 : size
    sA(ceil(i/3),i-((ceil(i/3)-1)*3)) = colorPerm(i);
end
return
