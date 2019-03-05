+++++++++++++++++
Examples
+++++++++++++++++
------------------------------
Brick/HardwareObject example
------------------------------
Each HardwareObject is defined as a python class. We can have different instances of a given HardwareObject.

So, we need to define a class for each HardwareObject type.
Each instance of this class will correspond to a specific Device.
This HardwareObject is derived from a base class (the Basic class is Device).
The definition (python class) is stored in a single file, inside the HardwareObjects folder.
The filename MUST be the same as the class name. This class MUST define a series of
methods inherited from the Base class an other necessary methods to provide specific features.

.. warning::

    It is of course, always possible to import PyTango and use it directly within the
    HardwareObject class.  However, it is strongly recommended the implementation
    through the `HardwareObjects` i.e. using the `Channels` and `Commands` within the
    Sardana support as this will make the code more re-usable and maintainable.

To illustrate the use of Bricks and HardwareObjects let's work on an example.
Let's analyze the case of  creating a  *machine info* pane inside a graphical
application (like MXCuBE). The following files will be needed:

* `MachineInfoBrick.py`
     Defines the graphical presentation of the Machine information. It will
     receive by configuration of the application a reference to the MachineInfo
     hardware object described below. It will then connect signals coming from it
     to corresponding update methods.

* `MachineInfo.py`
     HardwareObject code that will connect to the channels from its configuration
     It will receive in this way information from device servers and it will
     decide to emit the information upwards to the Brick (or another HardwareObject)

* `machinfo.xml`
     configuration of the hardware object. it will define one instance of
     a MachineInfo object and its configuration parameters like the
     machine current `Channels` that will be polled.

* `<application>.yml`
     configuration of the application, includes the declaration
     of an instance of a `MachineInfoBrick` and assigns
     `/machinfo` object to the `MachineInfoBrick`.

---------------------------------------
How to test one hardware object alone
---------------------------------------
First, one need to source the correc resource file to set all environmental variables.
Once this is done, one can execute the test script provided by the MXCuBE to test
a single Hardware Object using a given `xml` configuration file. For this, enter the folder
containing the HardwareObject of interest and execute::

    python <path_to MXCuBE_Test_Environment.py> <HardwareObject> <xml configuration file>

------------------------------------
Implement a new processing pipeline
------------------------------------
.. warning::

    Use the python module ALBAClusterClient to submit jobs to the ALBA cluster:

    .. code-block:: bash

      from ALBAClusterClient import XalocJob
      job = XalocJob(job_type, *args)

    where job_type is a key from an internal jobs dictionary defining the running scripts.
    The arguments are passed directly to the run script.

    * Strategy calculation (current status)
      Uses EDNAInterfaceToMXCuBE plugin. The implementation is done in the ALBADataAnalysis.

    * AutoPorcessing calculation (current status)
      Uses GPhL autoproc plugin. The implementation is done in the ALBAAutoProcessing.
