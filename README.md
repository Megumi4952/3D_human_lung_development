# 3D_human_lung_development

This repository contains scripts used to process 3D light-sheet data of the developing human airway in the first trimester (6-12 post-conceptional weeks). 

Follow the scripts in order to process the datasets. 
The first script takes a segmented 8-bit image from Aivia's Pixel Classifier. Scripts are run in FIJI (.ijm), Python (ipynb), or Matlab (.m). 

Here is an overview of the scripts: 

1_FIJI_Tube_Filling.ijm 

Takes an image stack, runs a Median filter to smooth, then binarizes the image. Then, the airway tube is "filled." 
Once the script has run, go through the image stack and make manual corrections as necessary. Then, export the volume as an OBJ file. 


2_Meshlab.ipynb 

Takes the OBJ file exported from FIJI, then remeshes (simplifies) and inverts the mesh. Once this script is run, you can open it in a mesh-editing software (eg. Autodesk Meshmixer) for subtractive mesh-editing. 


3_Mesh_to_Image.ipynb 

Takes the mesh from the previous step, then coverts it back into an image volume with user-specific isotropic voxel units. 


4_Mesh_Simplification_for_Verge3d.ipynb 

Use this notebook only if required for visualization with Verge3D. 


5_SkeletonizewithBonej.ijm 

This notebook takes the isotropic volume from 3_Mesh_to_Image.ipynb and returns two image stacks: (1) skeletonized image, and (2) thickness map image. 


six_script_plot_loops.m 

This Matlab script takes the skeletonized image from the previous step, and returns loop locations in a csv.


7_Delooping.ipynb

This notebook takes the loop locations from the previous step and "de-loops" the skeleton based on the contour of the input image. 


8_proximal_pruning.ipynb 

This notebook gets rid of "spurious branches" found in the proximal region of the lung. 


9_Node_Positions.ipynb 

Use the notebook "LL_RL" for left lower lobe, or right lower lobe. 
Use the notebook "LU_RUM" for left upper lobe, or right upper-middle lobe. 
This notebook will ask for node ids of the root of segmental bronchi, and return a text file with its xyz coordinates. 


ten_process_networks.m 

This final matlab script takes the skeletonized image, thickness image, and node positions to convert the skeleton into a network. The final output are .dat tables noting node ids and positions, and edge (branch) widths. 
