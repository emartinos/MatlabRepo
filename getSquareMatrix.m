function sA = getSquareMatrix(size)
array = [];
if size<=6
    colorPerm = randperm(6,size);
    for i = 1 : size
        sA(ceil(i/3),i-((ceil(i/3)-1)*3)) = colorPerm(i);
    end
else
    colorPerm1 = randperm(6,6);
    colorPerm2 = randperm(6,size-6);
    for i = 1 : 6
        sA(ceil(i/3),i-((ceil(i/3)-1)*3)) = colorPerm1(i);
    end
        for i = 7 : size
        sA(ceil(i/3),i-((ceil(i/3)-1)*3)) = colorPerm2(i-6);
        end
end
return
