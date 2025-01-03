print("\\Clear"); 
print("Loading..."); 
image_title = getInfo("image.title"); 
image_dir = getInfo("image.directory"); 

print("Raw image name : "+image_title);
print("Path : "+image_dir);
print("\n");

run("Median...", "radius=4 stack");
run("Enhance Contrast...", "saturated=0.35 normalize process_all"); 
print("Step : 1/17 (Preprocessing)");


run("Make Binary", "method=Otsu background=Dark calculate black");
run("Options...", "iterations=1 count=1 black do=Nothing");
print("Step : 2/17 (Segmentation)"); 



run("Fill Holes", "stack");
run("Options...", "iterations=2 count=1 black do=Dilate stack");
run("Fill Holes", "stack"); 
print("Step : 3/17 (Binary treatment)");
 

run("Reslice [/]...", "output=3.000 start=Right avoid");
run("Fill Holes", "stack");
print("Step : 4/17 (Reslice 1/3)"); 


run("Reslice [/]...", "output=1.625 start=Right avoid");
run("Fill Holes", "stack");
print("Step : 5/17 (Reslice 2/3)");


run("Reslice [/]...", "output=1.625 start=Right avoid");
print("Step : 6/20  (Reslice 3/3)");

run("Flip Horizontally", "stack");
print("Step : 7/17  (Flip 1/3)");

run("Flip Vertically", "stack");
run("Fill Holes", "stack");
run("Options...", "iterations=2 count=1 black do=Erode stack"); 
print("Step : 8/17  (Flip 2/3)"); 


run("Invert LUT");
print("Step : 9/17 (Invert LUT)"); 

run("Flip Z");
print("Step : 10/17  (Flip 3/3)"); 

print("");
print("Step : 11/17 ...Size Opening 2D/3D ...That can take a certain time ...Let's take a hot chocolate ^^"); // add by Cadisha 28/09/2023
run("Size Opening 2D/3D", "Min Voxel Number=5000");



list = getList("image.titles");
for (i=0; i<list.length; i++){
	if (startsWith(list[i], "Reslice of") || startsWith(list[i], "MASK_") || startsWith(list[i], image_title)) {
		close(list[i]);
	} else {
		new_image = list[i];
	}
}

print("");
print("Step : 12/17 ...Save raw fiji mask as ome.tif format");

selectWindow(new_image);
run("OME-TIFF...", "save=" + image_dir + "raw-fiji-mask.ome.tif compression=Uncompressed");
run("Bio-Formats Importer", "open=" + image_dir + image_title +" color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");	
run("Merge Channels...", "c2=Reslice-sizeOpen c4=[" + image_title + "] create");
print("Step : 13/17 (Merge mask and raw)");

print("Step : 14/17...Now...Manual correction");
waitForUser("Manual Correction...");

selectImage("Composite");
run("Split Channels");
close("C2-Composite");
selectImage("C1-Composite");

//run("Duplicate...", "duplicate");
//selectImage("C1-Composite");
//run("Invert", "stack");
run("Options...", "iterations=1 count=1 black do=Nothing");
run("Fill Holes", "stack");
//run("Invert", "stack");
print("Step : 15/17 (Binary treatment)");

run("OME-TIFF...", "save=" + image_dir + "corrected-fiji-mask.ome.tif compression=Uncompressed");
print("Step : 16/17 (Save corrected fiji mask as ome.tif format)");

print("");
print("Step : 17/17...Export Stack As OBJ");
waitForUser("Export Stack As OBJ...");

close("*");
print("END ! Yeaaah !!");