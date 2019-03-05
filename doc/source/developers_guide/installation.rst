++++++++++++++
Installation
++++++++++++++

No installers exists yet on the MXCuBE project and its installation is highly
manual. Moreover, the application must be adapted for each site i.e. there is specific
code for each site (or even beamline) and therefore, a custom configuration os the
application is required for each site.

ALBA has its own fork of these repos::

    https://github.com/ALBA-Synchrotron/mxcube
    https://github.com/ALBA-Synchrotron/HardwareRepository

.. note::
    Our development and bug fixes are always uploaded to this forked repositories and PR are
    created from them to the canonical repositories.

.. note::
    We are working on the frozen version of the HardwareRepository (2.3.0) while a new
    API is being defined in the master branch (3.0.0). This means that current XALOC
    versions are just uploaded the the forked repository.

---------------------
Requirements
---------------------

General requirements
---------------------
The complete list of dependencies for the base installation of the `MXCuBE` can be found
in the `requirements.txt` file in the main repository folder.

Specific ALBA requirements
---------------------------
The current version of the MXCuBE code needs some specific python modules related to the
`Sardana` and `taurus` support. This extends some specific dependencies related to the ALBA
control system integration. The current version of the ALBA-MXCuBE requires:

* taurus >= 4.4
* sardana >= 2.4
* PyTango >= 9.0

In addition to these ALBA-specific requirements, some extra modules are required are extra modules and scripts with local developments
for the XALOC beamline:

+-----------------------+----------------------------------------------------+----------------------+
| Module name           | Repository                                         | Package              |
+=======================+====================================================+======================+
| bl13_modules          | https://git.cells.es/controls/bl13_modules         | pybl13               |
+-----------------------+----------------------------------------------------+----------------------+
| bl13_macros           | https://git.cells.es/controls/bl13_macros          | MacroServer_BL13     |
+-----------------------+----------------------------------------------------+----------------------+
| bl13_processing       | https://git.cells.es/controls/bl13_processing      | No package available |
+-----------------------+----------------------------------------------------+----------------------+
| bl13_mxcube_config    | https://git.cells.es/controls/bl13_mxcube_config   | No package available |
+-----------------------+----------------------------------------------------+----------------------+
| ALBAClusterClient     | https://git.cells.es/controls/ALBAClusterClient    | No package available |
+-----------------------+----------------------------------------------------+----------------------+
| lucid                 | https://github.com/mxcube/lucid2                   | No package available |
+-----------------------+----------------------------------------------------+----------------------+
| EDNA-MX               | https://github.com/ALBA-Synchrotron/edna-mx        | No package available |
+-----------------------+----------------------------------------------------+----------------------+

Additionally, the execution of the GPhL workflow requires two extra python modules to be installed:

* f90nml
* py4j

The requirements specified by the MXCuBE installation guide has been installed via `apt-get` when possible.
The non packaged modules has been installed manually (basically a git clone or a deployed version
using `PyCharm`) in two different locations, depending if the code need to be accessible only
for the `MXCuBE` application or need also to be accessed by other software in a different machine:

+-------------------+----------------------------------------+-----------------------+
| Package           | Non standard location                  | Required by           |
+===================+========================================+=======================+
| bl13_processing   | /beamlines/bl13/controls/devel/pycharm | ctbl1305 / claxaloc01 |
+-------------------+----------------------------------------+-----------------------+
| ALBAClusterClient | /beamlines/bl13/controls/devel/pycharm | ctbl1305              |
+-------------------+----------------------------------------+-----------------------+
| lucid             | /homelocal/sicilia/git                 | ctbl1305              |
+-------------------+----------------------------------------+-----------------------+
| EDNA-MX           | /beamlines/bl13/controls/devel/pycharm | claxaloc01            |
+-------------------+----------------------------------------+-----------------------+

Besides from the modules required by the application itself, there are some other software
required by the correct operation of the beamlines. Two of them are used to control and monitor
the beamline operation: the `XalocDiffractometer` and the `XalocBeamlineSupervisor`. This
two Device Servers MUST run in TANGO8.

--------------
Configuration
--------------

Local environment
------------------
No installer exists for MXCuBE2 (Qt version) yet. The installation is based on the proper configuration of
some environmental variables at the OS level defined in the `generic application launcher`.
The main variables that need to be set are:

* **MXCUBE_BASE**: Directory for the MXCuBE project and related configuration files.
* **MXCUBE_ROOT**: MXCuBE project folder.
* **MXCUBE_SITE**: Name of the specific site (i.e. ALBA).
* **MXCUBE_XML_PATH**: Path for the xml configuration files.
* **MXCUBE_GUI_PATH**: Path to the yaml gui files.
* **MXCUBE_LOG_PATH**: Path to the log and error files.

Also the `PYTHONPATH` needs to be modified to add the location of the MXCuBE code and also add
the launchers to the `PATH`.

In order to facilitate the installation and configuration of the application, a resource file (\*.rc) is
provided in the `bl13_mxcube_config` which includes all definitions of the environment variables.

Application launcher
--------------------
A `generic application launcher` is located into the `bin` folder of the main `MXCuBE` project:

    $MXCUBE_ROOT/bin/run_app.sh

This generic launcher uses the set of environment variables to start a given bliss framework
application. A default default launcher specific for `MXCuBE` can be found in the same
folder:

    $MXCUBE_ROOT/bin/run_app.sh `mxcube2`

This launcher calls the generic script to start the application. In order to use these files,
one needs to rename the default launcher matching the filename of the `yaml` file
(without the extension) defining the `Qt` front-end design.
