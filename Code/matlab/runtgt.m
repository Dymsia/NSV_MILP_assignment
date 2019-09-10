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
%     array of uavs on the bottom of targets
uavs = [270 250
    280 260
    345 252
    260 240
    304 230
    262 250
    275 260
    303 234
    294 250
    294 245];
X = AssignTargets(targets,uavs);
figure;hold on
for i = 1:length(uavs)
    plot([uavs(X(i,1),1) targets(X(i,2),1)],[uavs(X(i,1),2) targets(X(i,2),2)]); %plot a line between uav and target
    text(uavs(X(i,1),1),uavs(X(i,1),2),['uav' num2str(i)])
    text(targets(X(i,2),1),targets(X(i,2),2),['tgt' num2str(i)])
end
plot(uavs(:,1),uavs(:,2),'LineStyle','none','Marker','o','MarkerFaceColor','y')
plot(targets(:,1),targets(:,2),'LineStyle','none','Marker','o','MarkerFaceColor','b')