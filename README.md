# MJ232X-Master-Thesis
This repository contains both the data and scripts utilized for post-processing in the master thesis entitled "The Calibration of the Measurement System for Methane Pyrolysis in Rocket Nozzle Cooling Channels". 

## Contains
**Scripts**
- *Main:*
  - **REFPROP_post_processing.m:** Post-processes the data obtained by REFPORP generated files. Includes abs. change, rel. change, theoretical correction coefficients, uncertainty analysis. 
  - **Sensor_post_processing.m:** Post-processes the data from the sensor output log files. Includes abs. change, rel. change, experimental correction coefficients, corrected values, H2 sensitivies. 
 
- *Data extraction:*
  - **property.m:** Extracts data from REFPROP generated files.
  - **BGA_extract.m:** Extracts data from BGA244 log files.
  - **opTim_extract.m:** Extracts data from opTim log files.
  - **Xensor_extract.m:** Extracts data from XEN-TCG3880 log files.
 
- *Other:*
  - **Xensor_theoretical.m:** Post-processes the data from XEN-TCG3880 log files using the theoretical approach stated in the sensor manual. 
  - **temperature_variation.m:** Post-processes the experimentally obtained data where the temperature is varied. 
  - **pressure_variation.m:** Post-processes the experimentally obtained data where the pressure is varied. 

**Data**
- *REFPROP data:*
  - **Theoretical data**: Binary mixtures with H2+CH4, H2+N2. Trinary mixture with H2+CH4+C2H6. 

- *Sensor folder:*
  - **Experimental data:** Log files from BGA244, opTim, and XEN-TCG3880. The log files are modified to be readable by MATLAB.


## Important notes
- For future use with new experimental data, the sensor log files need to be modified to be readable by MATLAB. i.e. dots must be changed to commas and unreadable symbols must be removed.
- To succesfully run the *REFPROP_post_processing.m* and *Sensor_post_processing.m* scripts:
  - The path way to the data files need to be changed in all scripts to be read properly. The path way is labeled differently in all scripts, but does all contain the word *"path"*.
  - The variable *"compos"* represents the amount of mixtures being investigated and should be changed accordingly. 
- The *opTim_extract.m* does not remove deviating points when averaging. This was not discovered until the end. Thus, one need to either modify the *opTim_extract.m* script or manually remove the deviating points from the opTim sensor log files. 
