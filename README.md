BL13-Xaloc MXCuBE configuration
===============================

This project contains the configuration files to run MXCuBE and related applications @ BL13-Xaloc beamline.

The repository contains:

* *bin*: Launcher scripts based on `run_app.sh` base script
* *guis*: Default location for ALL gui configuration files.
* *hardaware_objects.xml*: Contains the configuration files for all HwObj intances in the MXCuBE and related applications.
* *icons*: ALBA sopecific icons for the front-end applications layout.

It also contains a resource file `MXCUBE.rc` used for exporting the resources required by MXCuBE.
This file needs to be sourced before starting any MXCuBE application in order to set the corresponding local environment variables.
One can automate the process by adding this file to the inital `bash.rc` or `bash_profile scripts`.
