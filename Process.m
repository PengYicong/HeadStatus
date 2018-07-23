% data = xlsread("Hanhan.xlsx");
% positionnumber = unique(data(:,1:2),"rows");
data = Zhuozhuo1;
max = 5;
min = -5;
resolution = 100;
step = (max-min)/resolution;
% %grid = zeros(resolution,resolution);
% grid = HeatGen(data,100,100,step,-5);
% imagesc(grid);
AngularData = data(:,4:5);
M = SphereMapGen(AngularData);
OrientationMap = zeros(180,360);
for i = 1:180
    for j = 1:360
        if j <= 180
            OrientationMap(i,j+180) = M(i,j);
        else
            OrientationMap(i,j-180) = M(i,j);
        end
    end
end
OH = zeros(180,360);
for i = 1:180
    for j = 1:360
        if (i > 1) && (j>1) && (i<180) && (j<360)
            OH(i-1,j-1) = OH(i-1,j-1) + 0.2*OrientationMap(i,j);
            OH(i+1,j-1) = OH(i+1,j-1) + 0.2*OrientationMap(i,j);
            OH(i-1,j+1) = OH(i-1,j+1) + 0.2*OrientationMap(i,j);
            OH(i+1,j+1) = OH(i+1,j+1) + 0.2*OrientationMap(i,j);
            OH(i-1,j) = OH(i-1,j) + 0.5*OrientationMap(i,j);
            OH(i,j-1) = OH(i,j-1) + 0.5*OrientationMap(i,j);
            OH(i-1,j) = OH(i-1,j) + 0.5*OrientationMap(i,j);
            OH(i-1,j) = OH(i-1,j) + 0.5*OrientationMap(i,j);
            OH(i,j) = OH(i,j) + OrientationMap(i,j);
        end
    end
end
% imagesc(OH);
% 
sphere3d(0.05*OH,-pi,pi,-pi/2,pi/2,0.1,5,'surf','spline',0.1);
colormap(1-gray);
