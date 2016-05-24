%function OutFile = ExtractData(filename, outfile)
%im = double(imread(filename));
z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 140; focus = 0.65; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5]; 
al_res = [5]; nn = [];
outfile = 'gridsequenceend.txt';

%im = im(100:end,100:end);

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);
bck = Disk((size(model.mask,1)-1)/2);
for i = 118:-2:0
    filename = sprintf('sub-sequence-%03i.png',i);
    im = double(imread(filename));
    posim = zeros(size(im));
    [err, bim, cim, sim, xc, yc, bc, cc, sc, len, imm] = FindPattern(im, model.mask, bck, bck);

    errarray = zeros(length(xc));
    linfile = fopen(outfile,'a');
    fprintf(linfile, 'count \t x_coord \t y_coord \t theta \t phi \t error\n');
    
    for j = 1 : length(errarray)
        errarray(j) = err(yc(j), xc(j));
        fprintf(linfile,'%3f \t %3i \t %3i \t %-1.4f \t %-1.4f \t %-4.4f\n',[j;xc(j);yc(j);model.theta(sc(j));model.phi(sc(j));errarray(j)]);
        posim(yc(j), xc(j)) = 200;
    end

    OutFile = fclose(linfile);
    if size(xc) ~= 0
        imagefile = [outfile(1:end-4),int2str(i),'.png'];
        posfile = ['pos-',imagefile]; 
        imwrite(imm,colormap(hot),imagefile,'png');
        imwrite(posim,posfile,'png');
    end

end
%end
