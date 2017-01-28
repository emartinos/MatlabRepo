%%

addpath('C:\Users\Admin\Desktop\Cogent2000v1.32\Toolbox')

cgloadlib
cgopen(1,0,0,0)
cgpencol(1,1,1) 
 cgalign('c','c') 
 cgfont('Times',21)
 cgtext('Every time a red spuare or a green triangle appears',0,40)  %odigies
 cgtext('Press the button 1 and then Enter, as fast as you can.',0,20)
 cgtext('In any other case', 0,0)
 cgtext('Press the button 0 and then Enter, as fast as you can.',0,-20)
cgtext('When you are ready, press Enter',0,-40)
 cgflip(0,0,0)


kd(28)=0; 
while ~kd(28) %keyboard inputs
  [kd,kp]=cgkeymap;    
kp=find(kp);    
end


cgpencol(1,1,1) 
cgpenwid(5)
cgdraw(0,5,0,-5)      %arxikos stavros
cgpencol(1,1,1) 
cgpenwid(5)
cgdraw(-5,0,5,0) 
cgflip(0,0,0)
pause(1.5); 

Timings = zeros(4 , 10); %variables for last matrix
red = false;
square = false;

%data.output = [];

for i = 1:10    %10 trials
    cgscale(30)


if i == 5 | i == 9  %force 5&9 to be red&square
    cgpencol(1,0,0);
    cgrect(0,0,5,5);
    cgflip(0,0,0);
    
   % presence_index = presence_cond(i);
    S1=tic    
    
    kd(11)=0;
    kd(2)=0;
    while ~(kd(11)| kd(2))
      [kd,kp]=cgkeymap;    
    kp=find(kp);    
    end
    
    S2=toc(S1);     %Timings (3rd just show when its a "yes" to be 1 , then "no" will be 0.
    Timings(1,i) = 1;
    Timings(2,i) = 1;
    Timings(3,i) = kd(2)
    Timings(4,i) = S2;
    
    cgscale(400)
    cgpencol(1,1,1) 
    cgpenwid(5)
    cgdraw(0,5,0,-5)      %stavros
    cgpencol(1,1,1) 
    cgpenwid(5)
    cgdraw(-5,0,5,0) 
    cgflip(0,0,0)
    pause(1.5)  
    
    red = false;
    square = false;
    
else
    
    x = randi(3)       %shapes
    y = randi(3)       %colours

    if y==1
        cgpencol(1,0,0);
        red = true;
    elseif y==2
        cgpencol(0,1,0);
    else 
        cgpencol(0,0,1);
    end

    if x == 1
        cgpolygon([0 4 -4],[4 -2.5 -2.5]) 
    elseif x ==2
        cgrect(0,0,5,5);
        square = true;
    else
    cgellipse(0,0,7,7,'f')
    end

    cgflip(0,0,0)
    
    S1=tic
    
    kd(11)=0;
    kd(2)=0;
    while ~(kd(11)| kd(2))
      [kd,kp]=cgkeymap;    
    kp=find(kp);    
    end
    
    S2=toc(S1); %timers for the last matrix showing 1.shape 2. colour 3. square or not 4. times
    if red 
        Timings(1,i) = 1;
    else
        Timings(1,i) = 0;
    end
    if square
        Timings(2,i) = 1;
    else 
        Timings(2,i) = 0;
    end
    Timings(3,i) =  kd(2)
    Timings(4,i) = S2;
    
    if ~(i == 10)
        cgscale(400)
        cgpencol(1,1,1) 
        cgpenwid(5)
        cgdraw(0,5,0,-5)      %stayros
        cgpencol(1,1,1) 
        cgpenwid(5)
        cgdraw(-5,0,5,0) 
        cgflip(0,0,0)
        pause(1.5)  
    end
    
    red = false;
    square = false;
    
    %data.output = [data.output; keypress(1)];
    %save('mydata',data)
end

end
Timings
cgscale(400)
cgpencol(1,1,1) 
 cgalign('c','c') 
 cgfont('Times',21)
 cgtext('The end',0,0)  %"the end"
 cgflip(0,0,0)
 pause(1.5);
 cgshut


%%











