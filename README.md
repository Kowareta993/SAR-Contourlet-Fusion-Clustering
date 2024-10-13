# SAR-Contourlet-Fusion-Clustering
<div align="left">
<img src="https://img.shields.io/badge/License-MIT-%23437291?logoColor=%236DB33F&color=%236DB33F"/>
<img src="https://img.shields.io/badge/Matlab-R2022b-%23437291?logoColor=%236DB33F&color=%236DB33F"/>
</div>

## Description

Matlab code for the method proposed in "Adaptive Contourlet Fusion Clustering
for SAR Image Change Detection" paper [[1]](#1).

In this paper, a novel unsupervised change detection method called adaptive Contourlet fusion clustering based on adaptive Contourlet fusion and fast non-local clustering is proposed for multi-temporal synthetic aperture radar (SAR) images.

## Installation

- Matlab R2022b (might be working in prior versions with some syntax changes)

## Usage
Run the main file in Matlab to see the results on the provided dataset.

Use the 'detection' function for applying the paper method to your data. This function takes two SAR images and applies the chosen clustering method (FCM, FGFCM, FNLC) on their contourlet fused difference image. 'nlevels' specifies the depth of the pyramid in the contourlet transform.

## Credits

[Contourlet Toolbox](https://github.com/Furoe/Countourlet_Toolbox) used for contourlet calculations

## Results
You can access clustering results along with charts and comparative tables in the "Results" folder.

<p align="center">
  <img src="./results/7.bmp">
</p>

## License
MIT license



## Contribution

Any contribution is welcomed.



## References
<a id="1">[1]</a> 
Zhang W, Jiao L, Liu F, Yang S, Liu J. Adaptive contourlet fusion clustering for SAR image change detection. IEEE Transactions on Image Processing. 2022 Mar 4;31:2295-308.