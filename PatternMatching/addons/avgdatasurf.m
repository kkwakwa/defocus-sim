avgFile1 = uigetfile('.txt');
avgdata = importdata(avgFile1,'\t',0);

xlin = 0:10:90;
ylin = 0:10:360;
[X,Y]  = meshgrid(xlin,ylin);
Z = griddata(avgdata(:,1),avgdata(:,2),avgdata(:,3),X,Y,'cubic');

surf(X,Y,Z)