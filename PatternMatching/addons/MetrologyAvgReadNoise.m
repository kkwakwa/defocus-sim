z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 140; focus = 0.65; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5]; 
al_res = [5]; nn = [];

r2deg = 57.2957795;
fitlist = zeros(1,5);

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);

outfile = 'metrology_data_n100_avg5.txt';
linfile = fopen(outfile,'w');

for i = 1:825
    thetadeg = round(model.theta(i)*r2deg);
    phideg = round(model.phi(i)*r2deg);
    for j = 1:5
        datfile = sprintf('noise-100-orientation_stats-%i-%i.txt',[i;j]);
        metdata = importdata(datfile,'\t',2);
        temptheta = find(metdata.data(:,4) == thetadeg,1, 'first');
        tempphi = find(metdata.data(:,5) == phideg ,1, 'first');
        fitlist(1,j) = metdata.data(max(temptheta,tempphi),1);
    end
    fitval = round(mean(fitlist));
    fitvar = round(std(fitlist));
    fprintf(linfile,'%i\t%i\t%i\t%i\n',[thetadeg;phideg;fitval;fitvar]);
end
fclose(linfile);