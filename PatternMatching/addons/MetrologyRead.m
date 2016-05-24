z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 140; focus = 0.65; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5]; 
al_res = [5]; nn = [];

r2deg = 57.2957795;

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);

outfile = 'metrology_data_822.txt';
linfile = fopen(outfile,'w');

for i = 1:20
    datfile = sprintf('orientation_stats-822-%i.txt',i);
    metdata = importdata(datfile,'\t',2);
%    thetarray = int16(metdata.data(:,4)*r2deg);
%    phiarray = int16(metdata.data(:,5)*r2deg);
    thetadeg = int32(model.theta(822)*r2deg);
    phideg = int32(model.phi(822)*r2deg);
    thetafit = find(metdata.data(:,4) == thetadeg,1, 'first');
    phifit = find(metdata.data(:,5) == phideg ,1, 'first');
    fitval = metdata.data(max(thetafit,phifit),1);
%    fitval = 100*(2^max(thetafit,phifit));
    fprintf(linfile,'%i\t%i\t%i\n',[thetadeg;phideg;fitval]);
end
fclose(linfile);