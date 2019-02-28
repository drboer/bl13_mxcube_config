
+++++++++++++++++++++
MXCuBE Features
+++++++++++++++++++++

----------------
user login
----------------

To use MXCuBE users must log in the system. 

User credentials correspond to those in ALBA Ldap system.  
If ldap credentials are validated **mxcube** will then check if
the user name correspond to a registered proposal in MIS with 
scheduled session corresponding to the present date.  If that is not
the case a session will be created ad-hoc.

Once, logged in, **mxcube** will save all the data generated during 
data collection in the corresponding user directory following a well-defined
scheme (see the :ref:`Data Storage page <folder_structure>` for details.  
At the same time **metadata** corresponding to data collections will
be written in the **ispyb** database (check below for details).

----------------
sample mounting 
----------------
On startup **mxcube** will request the **PyCats** sample changer (see :ref:`Sample Changer <sample_changer>` )
for samples present in the sample changer dewar. With this information **mxcube** will
present available samples both in the *Sample Tree* in the left panel of the graphical interface
and at the same time in the pane that is presented when clicking on the *SC Details* button.

Doing a mouse *righ-click* over the sample list in the *Sample Tree* will then let the user mount a
sample, or unmount the sample that is currently mounted. 

For more actions on the use of the sample changer user should use the *SC Details* pane. 
**mxcube** will show at all moments the sample that is currently mounted with a special icon. Samples
that were previously mounted (since **mxcube** was started) will be shown in blue in the *SC Details* pane.

The list of sample present in the dewar will be updated automatically and the corresponding
graphics will be automatically updated.

----------------
sample centring 
----------------

----------------
data collection 
----------------


Standard Collection
----------------------

Characterization
----------------------

Helical collection
----------------------

Mesh / Grid
----------------------

EnergyScan
----------------------

Advanced
----------------------


-------
ispyb
-------

