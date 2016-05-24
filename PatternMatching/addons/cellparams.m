z = 0; NA = 1.40; n0 = 1.52; n=1.46; n1 = 1.0; d0 = []; d = 0.02; d1 = []; 
lamem = 0.57; mag = 140; focus = 0.50; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5]; 
al_res = [5]; nn = [];

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);
bck = Disk((size(model.mask,1)-1)/2);