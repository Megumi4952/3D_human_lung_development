## Requirements

This project requires **Python 3.11.5** and a specific set of libraries for 3D image processing and visualization. The core dependencies are:

* **Python:** 3.11.5
* **Imaging & Processing:**
    * `scikit-image` (0.22.0)
    * `numpy` (1.26.0)
    * `scipy` (1.11.3)
    * `opencv-python` (4.8.1)
    * `tifffile` (2023.9.26)
* **3D Visualization:**
    * `napari` (0.4.18)
    * `vedo` (2023.5.0)
    * `vtk` (9.3.0)
* **Interoperability:**
    * `pyimagej` (1.4.1) / `openjdk` (11.0.9)
* **Environment Manager:** Conda (recommended)

You can recreate the exact environment using the provided `environment.yml` file:
```bash
conda env create -f environment.yml