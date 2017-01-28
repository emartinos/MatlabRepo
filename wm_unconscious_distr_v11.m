   function wm_unconscious_distr_v11
%%
% % ===================================================================== %
% % CS SUCCESSOR NAMING TASK %
% % ===================== %
% v1. WM set 6 digits
% v2. WM set 9 digits
% v5. task is now orientation discrimination.
% v6. No WM task. Added various prime timings.
% v7. Added multiple prime timings [0-absent, 29, 43, 57, 114]
% v8. 1. Made the task a detection task [target present vs absent]
%     2. removed the 0-absent condition
% v9. adjusted timings to 75Hz screen [26, 40, 53, 106]
% v10. increased number of trials to 192 per condition [768 total]
% v11. 1. Added a prime [congruent or incongruent] with 29ms duration
%      2. Increased duration of the target to 150ms

addpath 'C:\Program Files\MATLAB\R2010a\toolbox\Cogent2000v1.30\Toolbox'

data.subject = input('Subject ID = '); % Subject's ID starting with 01
if data.subject == 999 || data.subject == 998
    disp('*** TESTING MODE ***')
    data.clock   = clock %#ok<NOPRT>
    %     data.blocked = input ('Blocked design? (y = YES, n = NO) ', 's'); % 'y' = yes, 'n' = no
    %     data.Nblocks = input ('How many blocks?');
    resultFileName = 'TEST.mat'; % Creates result file using subject ID and run number.
else
    data.clock   = clock %#ok<NOPRT>
    data.name    = input ('Name: ','s'); % Subject's initials e.g. NK
    data.session = input('Session Number?');
    data.gender  = input ('Gender = ','s');
    data.age     = input ('Age = ');
    %     data.Nblocks = input ('How many blocks?');
    %     data.blocked = input ('Blocked design? (y = YES, n = NO) ', 's'); % 'y' = yes, 'n' = no
    %     data(str2double(data.subject)).load      = input ('Which Load? (1 = LOW, 6 = HIGH)', 's');
    resultFileName = ['s', int2str(data.subject) '_session' int2str(data.session) , '_v11.mat' ]; % Creates result file using subject ID and run number.
    % if file exists, prompt to choose a different file name.
    if exist(resultFileName,'file')
        error('FILE NAME EXISTS... Please choose a different name!');
    end
end
%% ==================== display parameters ============================= %
global background foreground fix_size penwidth pencolour fontname fontsize...
    exp memory block delay probe condMet cross mask gam
gam = 2.2;
mode=1;  %window=0, fullscreen=1, second screen = 2
resolution=3; %1=640x480, 2=800x600, 3=1024x768, 4=1152x864, 5=1280x1024, 6=1600x1200
% Globalize there variables (see: help global)

% ========================== Configure Cogent ========================= %
% Create variables for configuration
background      = [0.5 0.5 0.5] .^ (1 / gam); % Clear background as mid-gray gamma 2.2 corrected.
foreground      = [0 0 0]; % black.
fontname        = 'Arial';
fontsize        = 20;
nbuffers        = 10;
number_of_bits  = 0;
scale           = 0;
fix_size        = 15;
penwidth        = 15;
pencolour       = [0 0 0];
% Enter previously created variables (instead of numbers) into Cogent config_display command
config_display(mode,...
    resolution,...
    background,...
    foreground,...
    fontname,...
    fontsize,...
    nbuffers,...
    number_of_bits,...
    scale)
config_keyboard;
% config_sound;
%% ========================== Start Cogent ============================= %
start_cogent; % necessary
% ====================================================================== %
% Experimental Conditions

% load_conds          = repmat([ones(4,1);1+ones(4,1)],1,1);
cross_prime         = repmat([ones(2,1);1+ones(2,1)],24,1);
cross_probe         = repmat([ones(1,1);1+ones(1,1)],48,1);
timings_26   = ones(96,1)*26;
 
conds  = [cross_prime cross_probe];

% Now create 4th column that codes congruency (1=congruent; 0=incongruent)
for i = 1 : length(conds)
    if conds(i,1) == conds(i,2) % if prime position same as probe position
        conds(i,3) = 1; % congruent
    elseif conds(i,1) ~= conds(i,2)
        conds(i,3) = -1; % incongruent
    end
end

data.conds(:,:,1) = [shuffleD(conds)];
data.conds(:,:,2) = [shuffleD(conds)];
data.conds(:,:,3) = [shuffleD(conds)];
data.conds(:,:,4) = [shuffleD(conds)];

% ====================================================================== %
% Initialize Variables
data.Ntrials  = length(data.conds);
data.Nblocks  = size(data.conds,3);
% data.trial    = [0];
data.MemSet   = [];
data.output   = [];
% =================
cgfont(fontname,fontsize);
cgpencol(pencolour)

for block = 1 : data.Nblocks
    data.trial    = 0;
    cgflip(background(1),background(2),background(3)); cgflip(background(1),background(2),background(3)); % clear background color
    cgtext(['Start block ', int2str(block) ' of ' int2str(data.Nblocks)],0,100); % create buffer with text to start block
%     cgtext(['Timing ', int2str(data.conds(1,4,block))],0,200); % create buffer with text to start trial
    cgflip(background(1),background(2),background(3)); % display buffer
    waitkeydown(inf); % wait for a key press
    fixation(fix_size,'+'); % create fixation cross buffer
    cgflip(background(1),background(2),background(3)); % display buffer
    waitkeydown(1000); % stay on screen 1000ms waiting for a key press
    % ====================================================================== %
    % while current trial number is less than desired number of trials
    while data.trial < data.Ntrials
        % do the successor test (look in function for explanation)
        [condMet] = succDigitTest;
        if condMet == 0 % if no more than 2 digits are consecutive
            data.trial = data.trial + 1; % add 1 to trial index variable
            % Conditions' Variables 
%             memory.load            = data.conds(data.trial,1,block);
%             cross.prime.presence   = data.conds(data.trial,1,block);
            cross.prime.position   = data.conds(data.trial,1,block);
            cross.probe.position   = data.conds(data.trial,2,block);
            cross.probe.congruency = data.conds(data.trial,3,block);
            % ============================================================== %
            % Experimental Parameters (e.g. durations)
%             switch memory.load
%                 case 1
%                     memory.duration = 500;
%                 case 2
%                     %                     memory.duration = 1500; % this is wm set 6 duration
%                     memory.duration = 2000; % this is wm set 9 duration
%             end
            cross.respDur  = 3000;
            mask.pre_duration     = 500;
            mask.post_duration    = 50;
            cross.prime.duration  = 26;%data.conds(data.trial,3,block);
            cross.probe.duration  = 150;
            % ============================================================== %
            % Start Trial
            cgflip(background(1),background(2),background(3));
            cgtext(['Start Trial ', int2str(data.trial) ' of ' int2str(data.Ntrials)],0,100); % create buffer with text to start trial
%             cgtext(['Timing ', int2str(cross.prime.duration)],0,200); % create buffer with text to start trial
            cgflip(background(1),background(2),background(3)); % display buffer
            waitkeydown(inf); % wait for a key press
            fixation(fix_size,'.'); % create fixation cross buffer
            cgflip(background(1),background(2),background(3)); % display buffer
            %         waitkeydown(1000); % stay on screen 1000ms waiting for a key press
            wait(500);
            % =========================================================== %
            %             MemorySet % call Memory set function
            % =========================================================== %
            
            %             display_arc_premask
            %             display_prime
            %             display_arc_postmask
            
            display_mask_prime_mask_probe
%             display_probe
            
            % ============================================================== %
            %             MemoryProbe % this is the memory probe function
            % ============================================================== %
            if exp.ABORT
                break
            else
                data.output = [data.output;...
                    cross.probe.rt...
                    cross.acc...
                    cross.prime.position...
                    cross.probe.position...
                    cross.probe.congruency...
                    cross.respOnset...
                    cross.resp.key...
                    cross.resp.time...
                    cross.resp.n...
                    cross.probe.duration...
                    cross.respOffset...
                    mask.pre_OnsetTime...
                    mask.pre_OffsetTime...
                    mask.pre_actualDuration...
                    mask.pre_duration...
                    cross.prime.OnsetTime...
                    cross.prime.OffsetTime...
                    cross.prime_actualDuration...
                    cross.prime.duration...
                    mask.post_OnsetTime...
                    mask.post_OffsetTime...
                    mask.post_actualDuration...
                    mask.post_duration...
                    cross.probe.OnsetTime...
                    cross.probe.OffsetTime...
                    cross.probe_actualDuration...
                    ];
                    save(resultFileName,'data');
            end
        end % condMet
    end % trial
    if exp.ABORT
        break
    else
        save(resultFileName,'data');
    end
end % block
wait(1000);

cgflip(background(1),background(2),background(3));
cgtext('End of Experiment',0,100);
cgtext('Thank You for Participating',0,0);
% cgtext('Please Find Experimenter in Room 403',0,-100);
cgflip(background(1),background(2),background(3)); % display buffer
waitkeydown(5000); % wait for a key press

stop_cogent

% % ======================================================================= %
% % DATA ANALYSES SECTION
% % ======================================================================= %

congr = 1;
inCongr = -1;

crossACC   = data.output(:,2);
crossRT    = data.output(:,1);
congruency = data.output(:,5);
% ======================================================================= %
% Cross ACC
data.cross.acc(1) = mean(crossACC(~isnan(crossACC))); % overall RT
data.cross.acc(2) = mean(crossACC(congruency == congr   & ~isnan(crossACC))); % overall RT
data.cross.acc(3) = mean(crossACC(congruency == inCongr   & ~isnan(crossACC))); % overall RT

% Cross RT
data.cross.rt(1) = mean(crossRT(~isnan(crossACC))); % overall RT
data.cross.rt(2) = mean(crossRT(congruency == congr   & ~isnan(crossACC))); % overall RT
data.cross.rt(3) = mean(crossRT(congruency == inCongr   & ~isnan(crossACC))); % overall RT

% save data
save(resultFileName,'data');
% ======================================================================= %
% ======================================================================= %

figure(1)
subplot(1,2,1);
bar(data.cross.acc, 'k');
title('CROSS ACC');
set(gca,'XTick',1:3, 'XTickLabelMode','manual', 'XTickLabel',{'Overall', 'Congr', 'Incongr'},'FontSize',10)
xlim([0 4]);

subplot(1,2,2);
bar(data.cross.rt, 'k');
title('CROSS RT');
set(gca,'XTick',1:3, 'XTickLabelMode','manual', 'XTickLabel',{'Overall', 'Congr', 'Incongr'},'FontSize',10)
xlim([0 4]);

% Save figure
barFileName = ['s', int2str(data.subject) '_session' int2str(data.session) ,'_probe_results', '.fig' ];
saveas(gca,barFileName);
% ======================================================================= %

function [condMet] = succDigitTest
%%
% This function tests for consecutive digits in a set of digits.
% The set of digits is supplied in the main experiment called WMSet.
% If more than 2 digits (>2) are consecutive, in ascending or descending
% order, then condMet == 1, otherwise condMet == 0 .
%
% NK March 2009
% 207, 26 Bedford Way, UCL.

global WMSet MemSet exp MemSetNum
exp.ABORT = false;
WMSet = [...
    %     '0' ...
    '1' ...
    '2' ...
    '3' ...
    '4' ...
    '5' ...
    '6' ...
    '7' ...
    '8' ...
    '9' ...
    ];
succD(1) = 0;
succD(2) = 0;
MemSet = WMSet';
MemSet(:,1) = MemSet;
MemSet(:,2) = shuffleD(MemSet);
MemSetNum(1) = str2double(MemSet(1,2));
for i = 2 : size(MemSet,1)
    MemSetNum(i) = str2double(MemSet(i,2));
    if MemSetNum(i) == MemSetNum(i-1) + 1
        succD(1) = succD(1) + 1;
        succD(2) = 0;
    elseif MemSetNum(i) == MemSetNum(i-1) - 1
        succD(1) = 0;
        succD(2) = succD(2) + 1;
    end
    if succD(1) > 1 | succD(2) > 1
        condMet = 1;
        break
    else
        condMet = 0;
    end
end

return

function fixation(fix_size,fixSymbol)
cgpenwid(fix_size);
cgtext(fixSymbol,0,0);
return

function display_mask_prime_mask_probe
global background cross exp mask gam
exp.ABORT = false;
cgflip(background(1),background(2),background(3)) .* 1000;

mask_jitter_x = random('Normal',0,50,1,200); % [mean 0, std 50, 1 row, 200 columns]
mask_jitter_y = random('Normal',0,50,1,200);

% ====================================================================== %
% Pre-mask
hx1 = 0;
hy1 = 50;
hx2 = 0;
hy2 = 50;

cgpencol(0,0,0)
cgpenwid(.1)
% cgdraw(hx1+mask_jitter_x,hy1+mask_jitter_y,hx2+mask_jitter_x,-hy2+mask_jitter_y)
cgdraw(hx1+mask_jitter_x,hy1+mask_jitter_y,hx2+mask_jitter_x,-hy2+mask_jitter_y)
% ====================================================================== %
vx1 = -50;
vy1 = 0;
vx2 = 50;
vy2 = 0;

cgpencol(0,0,0)
cgpenwid(.1)
cgdraw(vx1+mask_jitter_x,vy1+mask_jitter_y,vx2+mask_jitter_x,-vy2+mask_jitter_y)
% ====================================================================== %

mask.pre_OnsetTime = cgflip(background(1),background(2),background(3)) .* 1000;
waituntil(mask.pre_OnsetTime+ mask.pre_duration);
mask.pre_OffsetTime = cgflip(background(1),background(2),background(3)) .* 1000;
mask.pre_actualDuration = mask.pre_OffsetTime - mask.pre_OnsetTime

% ======================================================================= %
% ====================================================================== %
% Prime
xPositive = rand(1,1)*10+5;
xNegative = rand(1,1)*-10-5;
xPosition = [xPositive;xNegative];
% ====================================================================== %
% data.prime_bgr = [.1 .1 .1] .^ (1/gam);
% cgpencol(data.prime_bgr)
cgpenwid(.1)
% if cross.prime.presence == 1
    cgdraw(-20,0,20,0)
% end
% ====================================================================== %
vx1 = 0;
vy1 = 20;
vx2 = 0;
vy2 = 20;

% data.prime_bgr = [.1 .1 .1] .^ (1/gam);
% cgpencol(data.prime_bgr) 
cgpencol(0,0,0)
cgpenwid(.1)
% if cross.prime.presence == 1 
cgdraw(vx1+xPosition(cross.prime.position),vy1,vx2+xPosition(cross.prime.position),-vy2)
% end
% ====================================================================== %
cross.prime.OnsetTime = cgflip(background(1),background(2),background(3)) .* 1000;
waituntil(cross.prime.OnsetTime + cross.prime.duration);
cross.prime.OffsetTime = cgflip(background(1),background(2),background(3)) .* 1000;
cross.prime_actualDuration = cross.prime.OffsetTime - cross.prime.OnsetTime;
prime_actual_duration = cross.prime_actualDuration
% ====================================================================== %
% ====================================================================== %
% Post-mask
cgflip(background(1),background(2),background(3)) .* 1000;

hx1 = 0;
hy1 = 50;
hx2 = 0;
hy2 = 50;

cgpencol(0,0,0)
cgpenwid(.1)
% cgdraw(hx1+mask_jitter_x,hy1+mask_jitter_y,hx2+mask_jitter_x,-hy2+mask_jitter_y)
cgdraw(hx1+mask_jitter_x,hy1+mask_jitter_y,hx2+mask_jitter_x,-hy2+mask_jitter_y)
% ====================================================================== %
vx1 = -50;
vy1 = 0;
vx2 = 50;
vy2 = 0;

cgpencol(0,0,0)
cgpenwid(.1)
cgdraw(vx1+mask_jitter_x,vy1+mask_jitter_y,vx2+mask_jitter_x,-vy2+mask_jitter_y)
% ====================================================================== %
mask.post_OnsetTime = cgflip(background(1),background(2),background(3)) .* 1000;
% waituntil(mask.pro_OnsetTime + mask.duration);
waituntil(mask.post_OnsetTime + mask.post_duration);
mask.post_OffsetTime = cgflip(background(1),background(2),background(3)) .* 1000;
mask.post_actualDuration = mask.post_OffsetTime - mask.post_OnsetTime
% ====================================================================== %
% ====================================================================== %
% Probe
% xPositive = rand(1,1)*10+5;
% xNegative = rand(1,1)*-10-5;
% xPosition = [xPositive;xNegative];
% ====================================================================== %
% data.prime_bgr = [.1 .1 .1] .^ (1/gam);
% cgpencol(data.prime_bgr) 
% cgpenwid(.1)
% if cross.prime.presence == 1
    cgdraw(-20,0,20,0)
% end
% ====================================================================== %
vx1 = 0;
vy1 = 20;
vx2 = 0;
vy2 = 20;

% data.prime_bgr = [.1 .1 .1] .^ (1/gam);
% cgpencol(data.prime_bgr)
cgpencol(0,0,0)
cgpenwid(.1)
cgdraw([vx1+xPosition(cross.prime.position)*(cross.probe.congruency)],vy1,...
    [vx2+xPosition(cross.prime.position)*(cross.probe.congruency)],-vy2);

% ====================================================================== %
cross.probe.OnsetTime = cgflip(background(1),background(2),background(3)) .* 1000;
waituntil(cross.probe.OnsetTime + cross.probe.duration);
cross.probe.OffsetTime = cgflip(background(1),background(2),background(3)) .* 1000;
cross.probe_actualDuration = cross.probe.OffsetTime - cross.probe.OnsetTime;
probe_actual_duration = cross.probe_actualDuration
% ====================================================================== %
% ====================================================================== %
% Display Response Screen
cgflip(background(1),background(2),background(3));
cgtext('?',0,0);
cross.respOnset = cgflip(background,background,background) .* 1000;
cross.resp.key =[]; cross.resp.time = [];  cross.resp.n = [];
[cross.resp.key cross.resp.time cross.resp.n] = waitkeydown(cross.respDur);
% waituntil(cross.respOnset + cross.respDur);
cross.respOffset = cgflip(background,background,background) .* 1000;
% ====================================================================== %
% ==================== ACC and RT of Detection Task ===================== %
Left_key   = 76; % Pad1
Right_key  = 77; % Pad2
breakKey  = 52; % ESC
exp.ABORT = false;
Left = 2;
Right  = 1;

if cross.resp.n == 1
    if cross.resp.key == Left_key || cross.resp.key == Right_key
        cross.probe.rt = cross.resp.time - cross.respOnset;
        if cross.probe.position == Left
            if cross.resp.key == Left_key
                cross.acc = 1;
            else
                cross.acc = 0;
            end
        elseif cross.probe.position == Right
            if cross.resp.key == Right_key
                cross.acc = 1;
            else
                cross.acc = 0;
            end
        end
    elseif cross.resp.key == breakKey
        cross.rt = NaN;
        cross.acc = NaN;
        exp.ABORT = true;
    else
        cross.resp.key(1) = NaN;
        cross.resp.time(1) = NaN;
        cross.resp.n(1) = NaN;
        cross.rt = NaN;
        cross.acc = NaN;
    end
else
    cross.resp.key(1) = NaN;
    cross.resp.time(1) = NaN;
    cross.resp.n(1) = NaN;
    cross.rt = NaN;
    cross.acc = NaN;
end
return

