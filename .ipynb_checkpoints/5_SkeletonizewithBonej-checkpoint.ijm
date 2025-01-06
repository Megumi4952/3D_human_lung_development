// IMPORTANT : Put 5_Part2_PruneSkeletonMacro.bsh file in FIJI macros folder !

/*
Check if those Fiji plugins are installed : 
clijx-assistant
clijx-assistant-extensions
3D ImageJ Suite
BoneJ
IJPB-Plugins
*/

// Image opening possibilities :
// Option 1 : With the path of an unique image (replace path by yours)
//open("F:/Megumi/Dropbox (DBOX-EQS1)/Skeleton by Lobe/Left Upper Lobe/EH3138LU-P9.0(9.7)/Trial 2/4um/EH3138LU_Trial2_4um.tif");

// Option 2 : With directory if you have multiple image in a same folder
/*
 * directory = getDirectory("Input directory");
 * files = getFileList(directory);
 * for (i = 0; i < files.length; i++) {
 * 	open(directory+files[i])
 * 	// Put the script below in the loop !
 *  }
 */
 
 // Option 3 : Just open an image and run the script
 

image_dir = getInfo("image.directory");

run("Options...", "iterations=1 count=1 black do=Nothing");
run("Fill Holes", "stack");



img_slice = nSlices;
raw_image_title = getInfo("image.title");
image_title = substring(raw_image_title, 0, lastIndexOf(raw_image_title, ".")); // If .tif file
//image_title = substring(image_title, 0, lastIndexOf(image_title, ".")); // Add that line if ome.tif file




selectImage(raw_image_title);
title = "Pixels Value";
width=7; height=7; voxel=7;
Dialog.create("Enter pixels value");
Dialog.addNumber("Width:", width);
Dialog.addNumber("Height:", height);
Dialog.addNumber("Voxel Depth:", voxel);
Dialog.show();
width = Dialog.getNumber();
height = Dialog.getNumber();
voxel = Dialog.getNumber();


run("Properties...", "channels=1 slices="+img_slice+" frames=1 pixel_width="+width+" pixel_height="+height+" voxel_depth="+voxel);

// Thickness Part
Stack.setXUnit("pix");
run("Thickness", "mapchoice=[Trabecular thickness] showmaps=true maskartefacts=true");
saveAs("Tiff", image_dir+ "Tb_corrected.tif");

// Skeleton part
selectImage(raw_image_title);
Stack.setXUnit("um");
run("Properties...", "channels=1 slices="+img_slice+" frames=1 pixel_width="+width+" pixel_height="+height+" voxel_depth="+voxel);

run("CLIJ2 Macro Extensions", "cl_device=[Quadro RTX 8000]");
//run("CLIJ2 Macro Extensions", "cl_device=");


// bone j skeletonize
image1 = getInfo("image.title");
Ext.CLIJ2_push(image1);
image2 = "bone_j_skeletonize";
Ext.CLIJx_boneJSkeletonize3D(image1, image2);
Ext.CLIJ2_pull(image2);
img_slice = nSlices;

selectImage(image2);
Stack.setXUnit("um");
run("Properties...", "channels=1 slices="+img_slice+" frames=1 pixel_width="+width+" pixel_height="+height+" voxel_depth="+voxel);

//run("OME-TIFF...", "save=[F:/Megumi/Dropbox (DBOX-EQS1)/Skeleton by Lobe/Left Upper Lobe/EH3138LU-P9.0(9.7)/Trial 2/4um/EH3138LU_Trial2_4um_skel.tif] export compression=Uncompressed");
run("OME-TIFF...", "save=["+image_dir+"skeleton.tif] export compression=Uncompressed"); 



//selectImage(getImageID());
//setSlice(nSlices/2);


// Run Beanshell script
//beanshell_script = File.openAsString(getDirectory("macros")+"5_Part2_PruneSkeletonMacro.bsh");
//eval("bsh", beanshell_script);
//runMacro(getDirectory("macros")+"4_Part2_PruneSkeletonMacro.bsh")
//setSlice(nSlices/2);
//run("OME-TIFF...", "save=["+image_dir+image_title+"_skel_prune35.ome.tif] export compression=Uncompressed");

close("*");
print("\\Clear");
run("Clear BoneJ results");
print("Done.");