# SdipSureLet
Project for Developing Structured Deep Image Prior Frameworks
# Summary
Structured Deep Image Prior (SDIP) is a MATLAB-based project designed to implement advanced self-supervised image denoising and restoration techniques. The framework integrates Structured Deep Image Prior with Stein's Unbiased Risk Estimator (SURE) and Linear Expansion of Thresholding (LET) across scales to enhance the semantic clarity of the overall architecture and improve the performance of image restoration.
This package is developed for:
- **Experiments**
- **Development**
- **Implementation**
# Package structure
```plaintext
SdipSureLet/               
├── Itecode_SDIP_SURELET/                
│   ├── examples/...        
│   ├── saivdr/            
│   │   ├── dcnn
```
# Requirements
- MATLAB R2023b (recommended)
- Signal Processing Toolbox
- Image Processing Toolbox
- Deep Learning Toolbox
- Optimization Toolbox
# Recommendation
- MATLAB Coder
- GPU Code
# Brief Introduction

1. **Change to the working directory**:  
   Change the current directory to directory 'code' on MATLAB
   ```matlab
   >> cd Itecode_SDIP_SURELET 
3. **Set the path by using the following command:**
   ```matlab
   >> setpath
5. **Build MEX codes if you have MATLAB Coder.**
   ```matlab
   >> mybuild
6. **Several example codes are found under the second layer directory 'examples' of this package. Change the current directory to one under the second layer directory 'examples' and executes an M-file of which name begins with 'main,' such as**
   ```matlab
   >> main_xxxx
# Contact author

- [Jikai LI](https://github.com/ljkyjj),
 Niigata University,
 8050 2-no-cho Ikarashi, Nishi-ku,
 Niigata, 950-2181, JAPAN,
 https://www.eng.niigata-u.ac.jp/~msiplab/


# References
1. Jikai LI , Shogo MURAMATSU , “Structured Deep Image Prior for Image Denoising with Interscale SURE-LET“,  ITE Transactions on Media Technology and Applications, Dec 2024
2. Jikai LI , Shogo MURAMATSU , “Inter-Scale Sure-Let Denoise with Structured Deep Image Prior: Interpretable Self-Supervised Learning“, IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP) 2023
# Acknowledgement
This study was supported by JSPS KAKENHI Grant Number JP22H00512 and JST SPRING Grant Number JPMJSP2121.
# Developpers
Jikai LI
Shogo MURAMATSU

