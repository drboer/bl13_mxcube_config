++++++++++++++++++++
MXCuBE overview
++++++++++++++++++++
-------------
Introduction
-------------
`MXCuBE` is an application for the automation of Macromolecular
Crystallography (MX) experiments. It was initially developed at the ESRF.
Today it is the subject of a collaboration between a number of european
synchrotrons: ESRF, ALBA, Soleil, MaxIV, Bessy, EMBL, Elettra, LNLS (Brazil)
and the company GlobalPhasing. `MXCuBE` is used today in most MX beamlines
of those institutes. In particular, it is used at Xaloc, in ALBA for the
control and data collection of experiments.

`MXCuBE` is built on top of the `BlissFramework` application framework and relies on the
HardwareRepository communication layer, designed to interface the beamline instrumentation.
As such, `mxcube` is an instance of a `BlissFramework` application and its front-end design
and configuration is managed by this framework.

The `MXCuBE` application is the beamline control part of a wider suit of software packages linked
together around the automation of MX beamlines. `MXCuBE` includes features to communicate
with other of those software packages such as:

   * `ISPyB`: database for annotation of proposals, experiments and data analysis

   * `EDNA`: package (or collection of packages) for MX data analysis

The MXCuBE project is hosted at `github` and consists of a main `mxcube` repository,
with an additional submodule called `HardwareRepository`::

    https://github.com/mxcube/mxcube
    https://github.com/mxcube/HardwareRepository

A main project page with generic information about the collaboration is also hosted at github::

    http://mxcube.github.io/mxcube/

-----------------------------
The BlissFramework structure
-----------------------------
The `BlissFramework` is a library and application framework developed at the
ESRF for creation graphical applications for beamline control.

The core framework libraries are located in::

    <MXCuBE_ROOT>/BlissFramework

They implement all the core features to configure, instantiate and launch an
application. They also implement the logic to manage signals between Bricks (the GUI units),
Bricks to HardwareObjects (Interfaces to beamline instrumentation) or between HardwareObjects.

This two building blocks other than the core framework libraries, are collections of python classes
distributed with MXCuBE that implement most of MXCuBE features.

The Bricks
-----------
In the `BlissFramework` the graphical components are called `Bricks`. One  `Brick`
is a classical `QWidget` together with configuration and instrumentation communication
features.

`mxcube` distributes a collection of specific `Bricks` that compose its graphical user
interface::

    <MXCUBE_ROOT>/BlissFramework/Bricks

The HardwareObjects
--------------------
Access to specific hardware in the system is controlled by the application and
implemented in their corresponding `HardwareObject` classes::

    <MXCUBE_ROOT>/HardwareRepository/HardwareObjects

The `BlissFramework` core include features that allow the HardwareObjects to
work in terms of `Channels`  and `Commands`. `Channels` and `Commands` would be
defined at configuration time. 

`Channels` and `Commands` are a generic way to give access to different possible
control systems (Tango, Spec, Sardana, Epics, Tine...).  The `BlissFramework` 
includes code to support the implementation of Channels/Commands for those 
control systems. 

The configuration of the Hardware Objects is made via xml files, used to configure
specific properties and the definition of channels and commands to implement the
functionality required by each Hardware Object class.

The MXCuBE layout
-----------------------
The application layout is defined by the composition of a Qt application based on Bricks
and setup in a `yaml` file. This file is expected to be located in the path defined by
`MXCUBE_GUI_PATH`.

The file includes, for each of the Bricks, the parameters for the Brick 
initialization. Those parameters include in most cases one or more references
to Hardware Objects with which the Brick will interact. I also includes the list of
signal/slot connections between bricks.

The application configuration file can be edited with a text editor, but in a much
more convenient way by starting `mxcube` in design mode (add the -d flag when starting
the application).

There we can rearrange an configure the individual Brick and store the new configuration
in the `yaml` file.

Hardware Object configuration
------------------------------
Parameters for the initialization of hardware objects are given via `xml` configuration
files which are expected to be located in the path defined by `MXCUBE_XML_PATH`.

The name of the `xml` file is used to refer to a certain object
either in the configuration of other hardware objects or in assigning
hardware objects to MXCuBE `Bricks` configuration.

Tango and/or Sardana `Channels` and `Commands` required by `HardwareObjects`
are declared in  most cases in the `xml` files themselves. 
