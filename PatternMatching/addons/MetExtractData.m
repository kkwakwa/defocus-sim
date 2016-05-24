%function OutFile = ExtractData(filename, outfile)
%im = double(imread(filename));
z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 140; focus = 0.65; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5]; 
al_res = [5]; nn = [];
time = [1,2,4,6,8,10,20,40,60,80,100,200];

%im = im(100:end,100:end);

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);
bck = Disk((size(model.mask,1)-1)/2);
for i = 1:16
    for j = 1:12
        outfile = sprintf('area%i-%03i.txt',[i;time(j)]);
        filename = sprintf('area%i-%03i.png',[i;time(j)]);
        im = double(imread(filename));
        [err, bim, cim, sim, xc, yc, bc, cc, sc, len, imm] = FindPattern(im, model.mask, bck, bck);
        errarray = zeros(length(xc));
        linfile = fopen(outfile,'w');
        fprintf(linfile, 'count \t x_coord \t y_coord \t theta \t phi \t error\n');
        
        for k = 1 : length(errarray)
            errarray(k) = err(yc(k), xc(k));
            fprintf(linfile,'%3f \t %3i \t %3i \t %-1.4f \t %-1.4f \t %-4.4f\n',[k;xc(k);yc(k);model.theta(sc(k));model.phi(sc(k));errarray(k)]);
        end 
        OutFile = fclose(linfile);
    end
end
%end
