
+++++++++++++++++++++++++++
Troubleshooting
+++++++++++++++++++++++++++

-------------------
Log files
-------------------
The log files are located in the ctbl1301 machine::

    /tmp/mxcube-devel/mxcube-sicilia.{log,err,out}

-------------------
Device servers
-------------------
Several Tango Device servers are involved in the correct operation of the MXCuBE
application and they are accessed through the Hardware Objects:

+--------------------------+----------------------+---------------+
| DeviceServer/Instance    | Host                 | Tango version |
+==========================+======================+===============+
| Pool/bl13                | ibl1302.cells.es     | Tango 7       |
+--------------------------+----------------------+---------------+
| Macroserver/bl13         | ibl1302.cells.es     | Tango 7       |
+--------------------------+----------------------+---------------+
| PyCATS/bl13              | ibl1301.cells.es     | Tango 7       |
+--------------------------+----------------------+---------------+
| XalocDiffractometer/bl13 | bl13mxcube.cells.es  | Tango 8       |
+--------------------------+----------------------+---------------+
| XalocBeamlineSupervisor  | bl13mxcube.cells.es  | Tango 8       |
+--------------------------+----------------------+---------------+
| PySignalSimulator/bl13   | ibl1302.cells.es     | Tango 7       |
+--------------------------+----------------------+---------------+
| LimaCCDs/basler_oav      | pcbl1305.cells.es    | Tango 7       |
+--------------------------+----------------------+---------------+
| LimaCCDs/pilaus6m        | bl13pilatus.cells.es | Tango 7       |
+--------------------------+----------------------+---------------+
