*************
Data Analisys
*************

---------------
Introduction
---------------

`mxcube` enables the possibility to integrate different data analysis into the experiment sequence. There are three main post processing steps integrated to `mxcube` with the aim to:

   - Provide an optimized set of parameters for a given data collection (`Characterization`_).

   - Locate the best diffraction spot from a given sample (`Scoring`_).

   - Process the images for a given data collection (`Processing`_).

The processing pipelines associated to each step are triggered automatically by `mxcube`. 

---------------
Software (EDNA)
---------------

All the analysis of the images collected by `mxcube` is implemented using the `EDNA` package. `EDNA` (Enhanced automateD collectioN of datA) is a collaboration which has for aim an automatic collection of data on synchrotron beamlines.

More technically, `EDNA` is a plugin-based python software which provides a modular framework used to define specific processing pipelines. In this way, a post processing pipeline from `EDNA` point of view is nothing but a specific plugin (or concatenation of plugins) which receives some input data (files) and produces some output data (files) according to the algoritms implemented on the plugin or using third-party software executed by the plugin. The plugin data management is acomplished by defining specific data models for the input and output data for each plugin based on `xml` schemas. This architecture enables to pipe multiple plugins configuring complex pipelines.

Configuration
-----------------

`EDNA` plugins can be run on a regular workstation or in a HPC cluster. For XALOC, we have decided to install the package to the ALBA HPC cluster and define different job submission scripts to run each pipeline. This same scripts can be used to run the post processing pipelines afterwards.

In order to schedule the jobs to the cluster, `mxcube` uses the python module `ALBAClusterClient` to communicate with the ALBA HPC cluster queue system. This module provides the routines to submit the job and retrieve its status running remote commands using the `ssh` network protocol and the `subprocess` python module.

The configuration of the data analysys requires setting two environment variables in the `mxcube` machine:

   :CLA:
      The access to the cluster is done via `CLA` host. The job sumbission to the cluster system queue is always performed from this machine.

      Default value: claxaloc01.cells.es

   :POST_PROCESSING_SCRIPTS_ROOT:
      Path for the XALOC post processing scripts and launchers. These scripts are tracked using an internal git repository and they are manually deployed to the `mxcube` host machine.
   
      Default value: /beamlines/bl13/controls/processing

More details on the EDNA configuration can be found in the EDNA documentation.

--------------------
Pipelines
--------------------

These are the different processing pipelines configured to `mxcube`.

Characterization
--------------------
   :Plugin name: EDPluginControlInterfaceToMXCuBE-v1.3
   :Descritpion: Executes an optimization algorithm for finding the optimum set of collection parameters for a given crystal. It uses between 1 and 4 diffraction images and the results are parsed by `mxcube` to propose a `Diffraction Plan`.
   :Stage: After a Characterization Data Collection.

Scoring
-------------------
   :Plugin name: EDPluginControlDozor-v1.1
   :Description: Executes the `dozor` program to evaluate the diffraction quality of a given set of images. It is used by `mxcube` to create a `heat map` of a given protein crystal showing the best diffraction locations.
   :Stage: After a Raster Data Collection (not implemented yet).

Processing
-----------------
There are two processing ppipelines triggered by `mxcube` after a standard data collection:

   * EDNAproc:

      :Plugin name: EDPluginControlEDNAProc-v1.0
      :Description: Executes the fast autoprocessing pipeline from the `ESRF`.
      :Stage: After a Standard Data Collection.

   * autoPROC:

      :Plugin name: EDPluginControlAutoPROC-v1.0
      :Description: Executes the `process` pipeline from `GPhL`.
      :Stage: After a Standard Data Collection.

For each pipeline executed, a single folder is created in `scratch` partition of the ALBA HPC cluster and used as `working directory`. The plugin is the responsible to automatically generate and upload the results to `ISPyB` database. The results are basically measurement values stored in the database tables or result files whom location is stored in the data base. The results (data and files) are accessible by the users through the `ISPyB` portal.

However, all data generated and saved in the `working directory` can be recovered by the submission script and copied to the `POST_PROCESSING/RESULTS` user folder. Nevertheless, this folder is temporary and and will be never backuped in tape.
