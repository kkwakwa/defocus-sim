%parameters for generating the library images
z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 140; focus = 0.65; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5]; 
al_res = [5]; nn = [];

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);

sidelen = length(model.mask(:,1,1));
statimg = zeros(sidelen);
imlength = zeros(1,sidelen*sidelen);
mapval = 559;

inputs = rand(1,20001);
lstart = 1;
lend = 100;

rsum = 0;
finalimg = zeros(sidelen);
finalimg1 = zeros(sidelen+10);

%convert predicted image into probability map
for i=1:sidelen
    for j=1:sidelen
        rsum=rsum + model.mask(i,j,mapval);
        rlen = j+((i-1)*sidelen);
        imlength(rlen) = rsum;
    end
end

while lend < length(inputs(1,:))
    for i=lstart:lend
        coords = find(imlength(1,:)>inputs(1,i), 1, 'first');
        if mod(coords,sidelen) == 0
            icoord = round(floor((coords)/sidelen));
        else
            icoord = round(floor(coords/sidelen))+1;
        end
        if rem(coords,sidelen) == 0
            jcoord = round(sidelen);
        else
            jcoord = round(rem(coords,sidelen));
        end
        finalimg(icoord,jcoord) = finalimg(icoord,jcoord) + 1;
    end
    
    poissimg = poissrnd(poissval,sidelen+10,sidelen+10);
    finalimg1(6:end-5,6:end-5) = finalimg1(6:end-5,6:end-5) + finalimg;
    finalimg1 = finalimg1 + poissimg;
    finalimg1 = finalimg1/max(max(finalimg));
    imagefile = sprintf('grid-%i.png',lend);;
    imwrite(finalimg1,imagefile,'png');
    lstart = lend+1;
    lend = lend+100;
end
