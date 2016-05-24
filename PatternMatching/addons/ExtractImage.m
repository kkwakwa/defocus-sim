%Reads an image file full of defocused patterns, recognizes the patterns
%And then records all the data to a text file

filename = '7-8.png';
r2deg = 57.2957795;
im = double(imread(filename));
%posim = zeros(size(im));
z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 250; focus = 0.65; atf = []; ring = []; pixel = 16; pic = 0; be_res = []; 
al_res = []; nn = [];

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);
bck = Disk((size(model.mask,1)-1)/2);

[err, bim, cim, sim, xc, yc, bc, cc, sc, len, imm] = FindPattern(im, model.mask, bck, bck);

errarray = zeros(length(xc));
thetas = model.theta * r2deg;
phis = model.phi * r2deg;
outfile = ['out-',filename(1:end-4),'-txt-','.txt'];
linfile = fopen(outfile,'w');
fprintf(linfile, 'count \t x_coord \t y_coord \t theta \t phi \t error\n');

for j = 1 : length(errarray)
    errarray(j) = err(yc(j), xc(j));
    fprintf(linfile,'%3f \t %3i \t %3i \t %-1.4f \t %-1.4f \t %-4.4f\n',[j;xc(j);yc(j);model.theta(sc(j));model.phi(sc(j));errarray(j)]);
%    posim(yc(j), xc(j)) = 200;
end

OutFile = fclose(linfile);
%imm1 = imm/(max(max(imm)));

%if size(xc) ~= 0
%    imagefile = [outfile(1:end-4),'.png'];
%    posfile = ['pos-',imagefile]; 
%    imwrite(imm,colormap(gray),imagefile,'png');
%    imwrite(posim,posfile,'png');
%end
