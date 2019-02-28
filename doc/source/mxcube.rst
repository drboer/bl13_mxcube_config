
+++++++++++++++++++++
MXCuBE
+++++++++++++++++++++

------------------
Introduction
------------------

`mxcube` is an application for the automation of Macromolecular 
Crystallography (MX) experiments. It was initially developed at the ESRF.
Today it is the subject of a collaboration between a number of european
synchrotrons: ESRF, ALBA, Soleil, MaxIV, Bessy, EMBL, Elettra, LNLS (Brazil)
and the company GlobalPhasing. `mxcube` is used today in most MX beamlines 
of those institutes. In particular, it is used at Xaloc, in ALBA for the
control and data collection of experiments.

`mxcube` is built on top of the `BlissFramework` application framework from the
ESRF (see a short description below). As such, `mxcube` is an instance of a
`BlissFramework` application. The structure and the configuration of `mxcube` is 
designed by this framework.

`mxcube` is the beamline control part of a wider suit of software packages linked 
together around the automation of MX beamlines. `mxcube` includes features to communicate 
with other of those software packages such as:

   - `ISPyB`: database for annotation of proposals, experiments and data analysis

   - `EDNA`: package (or collection of packages) for MX data analysis

------------------
Installation
------------------

      

------------------------------------
BlissFramework application structure
------------------------------------

BlissFramework
-----------------
The `BlissFramework` is a library and application framework developed at the
ESRF for creation graphical applications for beamline control.

The core framework libraries are located in::
  
   /homelocal/sicilia/MXCuBE/mxcube/BlissFramework

They implement all the core features to configure, instantiate and launch an
application. They also implement the logic to manage signals between Bricks,
Bricks to HardwareObjects or between HardwareObjects. 

Other than the core framework libraries there are two collection of classes 
distributed with MXCuBE that implement most of MXCuBE features. These are

Bricks 
----------------
In the `BlissFramework` the graphical components are called `Bricks`. One  `Brick`
is a classical `QWidget` together with configuration and instrumentation communication
features.

`mxcube` distributes a collection of specific `Bricks` that compose its graphical user
interface. :: 

  /homelocal/sicilia/MXCuBE/mxcube/BlissFramework/Bricks

HardwareObjects
----------------
Access to specific hardware objects in the system controled by the application is 
implemented in their corresponding `HardwareObject` classes.  ::

  /homelocal/sicilia/MXCuBE/mxcube/HardwareRepository/HardwareObjects

Tango/Sardana and HardwareObjects
...................................
The `BlissFramework` core include features that allow the HardwareObjects to 
work in terms of `Channels`  and `Commands`. `Channels` and `Commands` would be
defined at configuration time. 

`Channels` and `Commands` are a generic way to give access to different possible
control systems (Tango, Spec, Sardana, Epics, Tine...).  The `BlissFramework` 
includes code to support the implementation of Channels/Commands for those 
control systems. 

It is of course, always possible to import PyTango and use it directly within the
HardwareObject class.  It is recommended though for `HardwareObjects` to use
`Channels` and `Commands` as this will make the code more re-usable between 
different beamlines and institutes. 

ALBA specific
-----------------

Code specific to Xaloc has been added in separate directories under both
the Bricks and HardwareObjects directories.

Example
----------------
To illustrate the use of Bricks and HardwareObjects let's work on an example. 
Let's analyze the case of  creating a  *machine info* pane inside a graphical 
application (like MXCuBE). The following files will be needed:

   - `MachineInfoBrick.py`
         Defines the graphical presentation of the Machine information. It will
         receive by configuration of the application a reference to the MachineInfo
         hardware object described below. It will then connect signals coming from it
         to corresponding update methods. 

   - `MachineInfo.py` 
         HardwareObject code that will connect to the channels from its configuration
         It will receive in this way information from device servers and it will  
         decide to emit the information upwards to the Brick (or another HardwareObject)
         
   - `machinfo.xml`  
         configuration of the hardware object. it will define one instance of
         a MachineInfo object and its configuration parameters like the
         machine current `Channels` that will be polled.

   - `<application>.yml`  
         configuration of the application, includes the declaration
         of an instance of a `MachineInfoBrick` and assigns
         `/machinfo` object to the `MachineInfoBrick`.
    

------------------
Configuration
------------------

As explained above MXCuBE is simply an instance of a BlissFramework
application.  As such it is a collection of Bricks and HardwareObjects

There are two levels on configuration:

Graphical configuration
---------------------------
The application layout: the layout of Bricks composing the application
is setup in a `yml` file. This file is located in:
`/homelocal/sicilia/MXCuBE/local/guis.yml/mxcube.yml`

The file includes, for each of the Bricks, the parameters for the Brick 
initialization. Those parameters include in most cases one or more references
to hardware objects with which the Brick will interact.

The application configuration files includes as well the list of signal/slot connections
between bricks. 

The application configuration file can be edited with a text editor, but in a much
more convenient way by starting `mxcube` in design mode::

    mxcube -d


Hardware Object configuration
--------------------------------
Parameters for the initialization of hardware objects
are given via `xml` configuration files. 

In Xaloc those `xml` configuration files are located in:

   `/homelocal/sicilia/MXCuBE/local/hardware_objects.xml`

The name of the `xml` file is used to refer to a certain object
either in the configuration of other hardware objects or in assigning
hardware objects to MXCuBE `Bricks` configuration.

Tango and/or Sardana `Channels` and `Commands` required by `HardwareObjects`
are declared in  most cases in the `xml` files themselves. 

------------------
Running mxcube
------------------

At the time of writing this documentation **mxcube** was installed in the machine *bl13mxcube*
Check with your local contact or controls correspondant to find out which machine contains the latest
**mxcube** version.

To start **mxcube** simply type `mxcube` in the command line or use the corresponding Desktop icon.
if available. 
