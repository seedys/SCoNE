# SCoNE
Codes for Paper----SCoNE: Spherical Consistent Neighborhoods Ensemble for Effective and Efficient Multi-View Anomaly Detection


## File Structure
dataset/:     Contains .mat format data for testing.
Demo.m:     The main execution file of the project.
data_preparation.m:     Converts single-view data in the dataset directory into a multi-view anomaly dataset with three types of anomalies.
Hypersphere_hashing.m:     Provides the specific implementation functions of SCoNE.
calAUC.m:     Function for calculating AUC.

## Installation
This project does not require special installation steps, simply clone or download the project files to your local system.

## Usage
Place your .mat format datasets in the dataset/ folder.
Modify the parameter settings in Demo.m as per your requirements, selecting different datasets and parameters.
Run the Demo.m file to execute the project.

## Hyperparameter Settings
t: Values can be 200 or 400 (fixed at 200 in the paper).
psi: Ranges from {2^1, 2^2,..., 2^8}, consistent with the settings in the paper.
k: Values can be {1, 3, 5, 7, 11, 21, 51, 101}, consistent with the settings in the paper.


## Test Datasets
For reference, the Demo test includes results executed on the MNIST dataset. Other datasets can be obtained from the following links and converted to .mat format in the dataset directory:
https://archive.ics.uci.edu/
https:www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/ 
https://cvml.ista.ac.at/AWA2/
https://www.vision.caltech.edu/datasets/
https://snap.stanford.edu/data/ego-Facebook.html

Please use Matlab R2023b or a newer version.
