function GaussianSphereMap = SphereMapGen(AngularData,fignum,sigma)
%%
%Preprocess: count the numbers in each sector
    for i = 1:size(AngularData,1)
        for j = 1:size(AngularData,2)
            if abs(AngularData(i,j)) < 0.01
                AngularData(i,j) = 0;
            end
        end
    end
    AngularGrid = zeros(360,360);
    SphereMap = zeros(180,360);
    for horizontal = 1:360
        for vertical = 1:360
            for index = 1:size(AngularData,1)
                if AngularData(index,1) >= (horizontal-1) && AngularData(index,1) < horizontal
                    if AngularData(index,2) >= (vertical-1) && AngularData(index,2) < vertical
                        AngularGrid(horizontal,vertical) = AngularGrid(horizontal,vertical) + 1;
                    end
                end
            end
        end
    end
    AngularGrid = AngularGrid.';
%%
%Mapping the data to the 360*180 surface map
    for m = 1:360
        for n = 1:90
            SphereMap(n+90,m) = AngularGrid(m,n);
        end
    end
    for m = 1:360
        for n = 271:360
            SphereMap(n-270,m) = AngularGrid(m,n);
        end
    end
    for m = 1:360
        for n = 91:270
            if m <= 180
            SphereMap(271-n,m) = SphereMap(271-n,m) + AngularGrid(m,n);
            else
                SphereMap(271-n,m) = SphereMap(271-n,m) + AngularGrid(m,n);
            end
        end
    end
    %%
    %Rotate the map horizontally 180 degree
    OrientationMap = zeros(180,360);
    for i = 1:180
        for j = 1:360
            if j <= 180
                OrientationMap(i,j+180) = SphereMap(i,j);
            else
                OrientationMap(i,j-180) = SphereMap(i,j);
            end
        end
    end
    %%
    %Gaussian Blur
    GaussianSphereMap = imgaussfilt(OrientationMap,sigma);
    figure(fignum),imagesc(GaussianSphereMap);
end
