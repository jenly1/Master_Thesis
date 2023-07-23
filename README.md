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
  - **Experimental data:** Log files from BGA244, opTim, and XEN-TCG3880. The log files are modified to be readable by MATLAB, i.e. dots have been changed to commas, unreadable symbols have been removed, etc.
