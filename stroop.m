


w=0;
colours = {'Blue';'Green';'Red';'Lilac';'Magenta';'White';'orange';'yellow'};
while w==0
      x = randi(8)
     c1 =randi(2)-1
     c2 =randi(2)-1
     c3 =randi(2)-1
     while ((c1==0&&c2==0&&c3==0)||(c1==1&&c2==1&&c3==1))
        c1 =randi(2)-1
        c2 =randi(2)-1
        c3 =randi(2)-1
     end
    cgopen(1,0,0,0)
    cgscale(50)
    cgpencol(c1,c2,c3)
    cgscale(35)
    cgfont('Arial',6)
    cgtext(colours{x},0,0)
    cgflip
%     w=waitforbuttonpress;
    
end
    