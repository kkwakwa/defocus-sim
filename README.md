## defocus-sim

The PatternMatching folder contains code used for determining the 3D orientation of single fluorescent molecules by defocused wide-field microscopy(references below). It has two functions.
* To predict the defocused fluorescent patterns produced by individual molecules given the dielectric properties of its surroundings and the nature of the imaging setup
* To match the predicted patterns to patterns produced by expeimental imaging of the same fluorescent molecules

The idea behind my added code is to quantify how accurate the pattern matching code is. This will be done by:
* Simulating defocused patterns by creating a 2D probability grid based on the predicted patterns, then filling it up with randomly generated photons.
* Stopping at intervals to run the randomly generated pattern through the pattern matching algorithm

The simulation will be used to quantify the effects of defocus distance, NA of objective and pixel size of the imaging system on the number of photons needed to achieve a fit of a certain level of accuracy. 

###### References:
1. [Orientation imaging of single molecules by wide-field epifluorescence microscopy](https://www.osapublishing.org/josab/abstract.cfm?uri=josab-20-3-554)
1. [Image Analysis of Defocused Single-Molecule Images for Three-Dimensional Molecule Orientation Studies](http://pubs.acs.org/doi/abs/10.1021/jp048188m0)
