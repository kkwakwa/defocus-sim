z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 140; focus = 0.65; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5]; 
al_res = [5]; nn = [];

r2deg = 57.2957795;
fitlist = zeros(1,6);
mapval = 559;

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);

outfile = 'focus_data_avg.txt';
linfile = fopen(outfile,'w');

thetadeg = round(model.theta(mapval)*r2deg);
phideg = round(model.phi(mapval)*r2deg);

for focus = 0.4:0.2:1.2
    for counts = 1:10        
        datfile = sprintf('focus_stats-%1.1f-%i.txt',[focus;counts]);
        metdata = importdata(datfile,'\t',1);
        temptheta = find(metdata.data(:,3) == thetadeg,1, 'first');
        tempphi = find(metdata.data(:,4) == phideg ,1, 'first');
        fitlist(1,counts) = metdata.data(max(temptheta,tempphi),2);
    end
    fitval = round(mean(fitlist));
    fitvar = round(std(fitlist));
    fprintf(linfile,'%1.1f\t%i\t%i\n',[focus;fitval;fitvar]);
end
fclose(linfile);