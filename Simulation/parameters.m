function [z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic] = parameters
  %Parameters for generating the library images
 
  z = 0;        %position of emitter above bottom of its layer in μm
  NA = 1.40;    %numerical aperture of objective
  n0 = 1.52;    %vector of refractive indices of the stack below the molecule's
                %layer
  n=1.49;       %refractive index of the molecule’s layer
  n1 = 1.0;     %vector of refractive indices of the stack above the molecule's
                %layer
  d0 = []; 
  d = 0.01;     %thickness of molecule's layer
  d1 = [];      %vector of layer thickness values of the stack below the 
                %molecule’s layer (length(d1) = length(n1)-1);
  lamem = 0.57; %center emission wavelength in μm
  mag = 100;    %imaging magnification
  focus = 0.6;  %defocusing value in μm, giving the distance the objective is
                %moved out of focus towards the sample
  atf = [];     %correction vector for coverslide thickness effects. If atf = []
                %, no cov-erslide effects are taken into account. If atf is a 
                %2-element vector, thefirst is the refractive index of the 
                %coverslide glass, the second the de-viation (in μm) of the
                %coverslide thickness from its design value;
  ring = [];    %optional parameter for a potential phase plate (default [])
  pixel = 10;   %side length of one pixel in μm
  pic = 0;      %if non-zero and non-empty, the calculated images are shown in
                %a figure(default 0)
  be_res = [15];%increment in polar angle (default 10°)
  al_res = [15];%increment in azimuthal angle (default 10°)
  nn = [10];    %the image is calculated over (2*nn +1)*(2*nn +1) pixels
                %(default nn = 10)

  
endfunction