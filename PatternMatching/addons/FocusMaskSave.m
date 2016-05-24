%parameters for generating the library images
z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = [];
lamem = 0.57; mag = 100; focus = 0.70; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5];
al_res = [5]; nn = [];

mapval = 826;
r2deg = 57.2957795;

for focus = 0:0.1:1.0
    model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);
    maskmax=max(max(model.mask(:,:,mapval)));
    mask2 = model.mask(:,:,mapval)*(60/maskmax);
    thetaint = int8(model.theta(mapval)*57.2957795);
    phiint = int16(model.phi(mapval)*57.2957795)
    imagename = ['image-',num2str(focus),'_',num2str(thetaint),'-',num2str(phiint),'.png'];
    imwrite(mask2,colormap(hot),imagename,'png');
end