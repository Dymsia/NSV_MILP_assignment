function nuav_ntarget = AssignTargets(targets,uavs)
% uavs = sortrows(uavs); %sort uav along x
% targets = sortrows(targets); %sort targets along x


barrier_matrix = zeros(length(uavs),length(targets)); %allocate memory for barrier matrix
figure;hold on
for i = 1:length(uavs)
    for j = 1:length(targets)
        plot([targets(i,1) uavs(j,1)],[targets(i,2) uavs(j,2)]); %plot a line between uav and target
        plot(uavs(:,1),uavs(:,2),'LineStyle','none','Marker','o','MarkerFaceColor','y')
        plot(targets(:,1),targets(:,2),'LineStyle','none','Marker','o','MarkerFaceColor','b')
    end
end
% fill in the barrier matrix
for i = 1:length(uavs)
    for j = 1:length(uavs)
        if j~=i
            for k = 1:length(targets)
                for l = 1:length(targets)
                    if k~=l
                        if ~isempty(intersections([uavs(i,1) targets(k,1) ],[uavs(i,2) targets(k,2)],[uavs(j,1) targets(l,1) ],[uavs(j,2) targets(l,2)]))
                            barrier_matrix(i,k) = barrier_matrix(i,k)+1;
                        end
                    end
                end
            end
        end
    end
end

x = transporte(ones(length(uavs),1),ones(length(targets),1),barrier_matrix);
[nuav_ntarget(:,1),nuav_ntarget(:,2)]  = find(x);
