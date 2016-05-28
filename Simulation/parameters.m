function [z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic] = parameters
  
  z = 0; 
  NA = 1.40; 
  n0 = 1.52; 
  n=1.49; 
  n1 = 1.0; 
  d0 = []; 
  d = 0.01; 
  d1 = [];
  lamem = 0.57; 
  mag = 100; 
  focus = 0.6; 
  atf = []; 
  ring = []; 
  pixel = 10; 
  pic = 0;
  be_res = [5];
  al_res = [5];
  nn = [10];
  
endfunction