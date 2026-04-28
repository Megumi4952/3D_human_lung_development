# 3D_human_lung_development

This repository contains scripts for processing 3D light-sheet data of the developing human airway in the first trimester (6-12 post-conceptional weeks). 

Follow the scripts in order to process the datasets. 
The first script takes a segmented 8-bit image from Aivia's Pixel Classifier. Scripts are run in FIJI (.ijm), Python (ipynb), or Matlab (.m). 

Here is an overview of the scripts: 

### 1_FIJI_Tube_Filling.ijm 

Takes an image stack, runs a Median filter to smooth, then binarizes the image. Then, the airway tube is "filled." 
Once the script has run, review the image stack and make manual corrections as needed. Then, export the volume as an OBJ file. 


### 2_Meshlab.ipynb 

Takes the OBJ file exported from FIJI, then remeshes (simplifies) and inverts the mesh. Once this script is run, you can open it in a mesh-editing software (eg. Autodesk Meshmixer) for subtractive mesh-editing. 


### 3_Mesh_to_Image.ipynb 

Takes the mesh from the previous step, then converts it back into an image volume with user-specific isotropic voxel units. 


### 4_Mesh_Simplification_for_Verge3d.ipynb 

Use this notebook only if required for visualization with Verge3D. 


### 5_SkeletonizewithBonej.ijm 

This notebook takes the isotropic volume from 3_Mesh_to_Image.ipynb and returns two image stacks: (1) skeletonized image, and (2) thickness map image. 


### six_script_plot_loops.m 

This Matlab script takes the skeletonized image from the previous step and returns loop locations in a CSV.


### 7_Delooping.ipynb

This notebook takes the loop locations from the previous step and "de-loops" the skeleton based on the contour of the input image. 


### 8_proximal_pruning.ipynb 

This notebook removes "spurious branches" in the proximal lung region. 


### 9_Node_Positions.ipynb 

Use the notebook "LL_RL" for left lower lobe, or right lower lobe. 
Use the notebook "LU_RUM" for the left upper lobe, or the right upper-middle lobe. 
This notebook will prompt for the node IDs of the root of the segmental bronchi and return a text file containing their XYZ coordinates. 


### ten_process_networks.m 

This final MATLAB script takes the skeletonized image, the thickness image, and the node positions to convert the skeleton into a network. The final output are *.dat tables noting node ids and positions, and edge (branch) widths. To test this script, download the data in "Test_data/ten", unzip it in the same folder as this script, and RUN the script in Matlab.

### System requirements

To run the Python scripts, you must install the requirements in "requirements_part.md" (installation time of about 10 min).

To run the MATLAB scripts, you must install MATLAB R2022a (or newer), including the 'Image Processing Toolbox' and the 'Statistics and Machine Learning Toolbox' (installation time of about 10 min).
