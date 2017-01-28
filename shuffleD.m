function sA = shuffleD(sortedArray)
% rng('shuffle')
n = size(sortedArray,1);
randIndex = randperm(n);
for i = 1 : n 
    sA(i,:) = sortedArray(randIndex(i),:);
end
return