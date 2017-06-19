# metro-groomin
## workspace for signal processing and filtering

Contains various MATLAB and C++ implementations of statistical methods and filtering/processing algorithms frequently used in digital signal processing and systems engineering.

For MATLAB tools, it is recommended you add the matlab/ directory to your PATH

### Directory Structure
| matlab/                |                                                                                             |
|:---------------------- |:--------------------------------------------------------------------------------------------| 
| block-convolution/     | Convolution algorithms for use on fixed-size sample blocks, does not include sample history |
| block-filters/         | Simple implementations of filters using fixed size blocks                                   |
| filter-iir-sos/        | Infinite Impluse Response (IIR) filter design helper using second-order sections            |
| util/                  | Reusable utilities for general use in DSP work                                              |
