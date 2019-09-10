%  case 2
% put a breakpoint to the line 99 and see how it works step by step
% array of targets
close all;
targets = [300 300
    350 350
    400 300
    450 250
    400 200
    300 150
    250  180
    110 200
    277 320
    344 400];
%     array of uavs on the left of targets
% uavs = [250 101
%            224 113
%            231  136
%            260 89
%            244 130
%            245 99
%            198  123
%            205 153
%            211 145
%            258 164];
%     array of uavs on the top of targets
% uavs = [120 50
%         130 60
%         95  52
%         110 40
%         154 30
%         112 50
%         125 60
%         153 34
%         144 50
%         144 45];
%     array of uavs on the bottom of targets
uavs = [280 250
    200 240
    345 202
    220 240
    304 230
    292 250
    275 260
    303 234
    294 250
    294 245];
uavs = sortrows(uavs); %sort uav along x
distr = zeros(10,2); %array with targets according to uavs
temp = targets; %auxillary variable for keeping targets array in safety
figure;
plot(uavs(:,1),uavs(:,2),'LineStyle','none','Marker','o','MarkerFaceColor','y')
hold on
plot(targets(:,1),targets(:,2),'LineStyle','none','Marker','o','MarkerFaceColor','b')
hold on
Quarter = 1; %starting quarter of coordinate space
for i = (1:length(uavs))
    indq = []; 
    while isempty(indq)%check quarters for free targets
        switch Quarter
            case 1
                indq = find(temp(:,1)>=uavs(i,1)&temp(:,2)>=uavs(i,2)); %I quarter
            case 2
                indq = find(temp(:,1)<uavs(i,1)&temp(:,2)>=uavs(i,2)); %II quarter
            case 3
                indq = find(temp(:,1)<uavs(i,1)&temp(:,2)<uavs(i,2)); %III quarter
            case 4
                indq = find(temp(:,1)>=uavs(i,1)&temp(:,2)<uavs(i,2)); %IV quarter
        end
        if isempty(indq) %change quarter if there are no free targets
            if Quarter == 4
                Quarter = 1;
            else
                Quarter = Quarter + 1;
            end
        end
    end
    if length(indq)>1 %if there is only one free target, then assign it to i-th uav (see else)
        points = [uavs(i,:); temp(indq,:)]; %array of free targets and current uav to form convexhull
        K = convhull(points(:,1),points(:,2)); %convexhull calculation
        plot(points(K,1),points(K,2))%draw current convex
         if(points(K(2),1) < points(K(end-1),1))% as an uav always the first and the last in K,
                                                % we can choose the previous K(end-1) or the next K(2) point to it.
                                                % Make choice for the left point
            distr(i,:) = points(K(2),:);        % assign to the i-th uav the next vertex of the convex
        else
            distr(i,:) = points(K(end-1),:);    % assign to the i-th uav the previous vertex of the convex
        end
        IndExclude = find(temp(:, 1)==distr(i, 1)&temp(:, 2)==distr(i, 2)); % remove the assigned target from 
                                                                            % the list of free targets
        temp(IndExclude,:) = [];
    else
        distr(i,:) = temp(indq,:); 
        temp(indq,:) = [];
        plot([distr(i,1) uavs(i,1)],[distr(i,2) uavs(i,2)]); %plot a line between uav and target
    end
    temp2 = distr(1:i,:);       %auxillary array for drawing the occupied targets
    plot(temp2(:,1),temp2(:,2),'LineStyle','none','Marker','o','MarkerFaceColor','k') %make accupied targets black
end
figure;hold on;
for i = 1:length(uavs)
            plot([distr(i,1) uavs(i,1)],[distr(i,2) uavs(i,2)],'Marker','o','MarkerFaceColor','k'); %plot a line between uav and target
end
