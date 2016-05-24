z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 100; focus = 0; atf = []; ring = []; pixel = 50; pic = 0; be_res = [10]; 
al_res = [10]; nn = [8];

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);

for i = 1:5:length(model.mask)
    maskmax=max(max(model.mask(:,:,i)));
    mask2 = model.mask(:,:,i)*(1/maskmax);
    [mask3,map]=gray2ind(mask2);
    thetaint = int8(model.theta(i)*57.2957795);
    phiint = int16(model.phi(i)*57.2957795);
    imagename = ['0nm/image-',num2str(thetaint),'-',num2str(phiint),'.png'];
    colormap(hot());
    imwrite(mask2,imagename,'png');
end