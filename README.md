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
   >> setpath
4. **Build MEX codes if you have MATLAB Coder.**
   >> mybuild
5. **Several example codes are found under the second layer directory 'examples' of this package. Change the current directory to one under the second layer directory 'examples' and executes an M-file of which name begins with 'main,' such as**
   >> main_xxxx
