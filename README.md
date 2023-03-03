# Hybrid modeling
This repository presents the proposed modeling codes for generating specific pore structure models. 
The Process_based.m is used to generate the grain packing model, which can be used as the initial input model. 
For example, the T1001.mat contains the three-dimensional coordinate position of grains. 
Then, the input digital image is obtained by applying the modelvoxel3D.m for digitization, such as the v1001.mat. 
The Morphology_based.m is cementing simulation algorithm based on mathematical morphology to obtain directional and quantitative modification models. 
The i7s030407.mat is an example of cementation growth along the direction of pore-body. 
Other codes are subprograms of the three main programs.
