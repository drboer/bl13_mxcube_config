
--------------------------
Instrumentation control
--------------------------

As a beamline control module, **mxcube** main task is to perform
data collections on samples by running pre-defined automatic procedures
with the beamline instruments. 

**mxcube** allows as well to control some of the instruments at the beamline
individually.

energy
---------
Beamline energy can be set to the value selected by the user from the right pane in 
the **mxcube** graphical interface. 

Energy value can be provided either as energy (values in kEV) or in terms of wavelength 
(values in angstroms).

The value can be also entered as a parameter for data collection procedures. In that case 
**mxcube** will set the monochromator to the parameter value before starting the data collection.

transmission
-------------
In the experimental hutch there exist a set of filters to attenuate the incoming beam intensity 
as required to reduce radiation damage on the sample.

**mxcube** allows to enter a *transmission* value as a percentage (0-100) of the maximum intensity
value. On request filters will be set to obtain the closest transmission value to the one required
by the user. Beware that due to the discrete nature of filter combinations the final tranmissin value
will not be exactly the one requested.  **mxcube** will show the real transmission value set.

As for the energy it is possible also to enter a transmission value as a parameter for data collection.
The transmission value will be set prior to the beginning of the data collection.

resolution
-------------

User can also select in the same way a *resolution* value.  The value could be entered either as *resolution*
or as detector distance (from the sample).  **mxcube** will move the detector to obtain the resolution required
by the user. 

As for energy and transmission, it is possible also to enter a resolution value as a data collection parameter.

high-level device servers
--------------------------

For the automation of tasks and verification of security conditions, there exist two special device servers at Xaloc.
The first one, the *diffractometer* device server will drive and coordinate the actions of all components of the 
diffractomter, i.e. motors, beamstop, lights, ln2 cover, camera, etc.. 
A second device server, the *beamline supervisor*, is in charge of coordinating the actions of the diffractometer and
other beamline devices like, for example, the detector motorization, the cyrostream positioning between others.

beamline supervisor
..........................

The beamline supervisor device server is in charge of supervising 
the combined operation of high level beamline instruments.

Four beamline phases (states) are defined and controlled by the 
beamline supervisor. The beamline supervisor will control all 
the instruments involved to set the beamline in a certain phase.

   - Transfer:  

     All the instruments are set in a safe position to proceed with
     sample mounting or unmounting. Diffractometer is driven to its
     mounting position, cryostream is set to protect samples and a 
     mechanism is activated to allow automatic movement of the cryostream
     off/on the sample to allow robot arm trajectory at the moment of the
     transfer.

     The detector is verify to be moved at a safe position for transfer to
     avoid collisions with the sample changer robot arm.

   - Collect
      
     The diffractometer is set at the position required for data collection. 
     The beamstop is moved to protect the detector from direct beam exposure, 
     backlight, used for sample viewing is set back to its down position

   - Sample viewing
     The diffractometer sets the conditions to allow sample viewing. The backlight
     is moved up for sample visualization, beamstop is at a lower position below its
     data collection operation position.
     
   - Beam view

diffractometer
...............

As the beamline supervisor coordinates the combined operation of beamline devices, the
diffractometer sample changer allows to see the collection of devices included in the
diffractometer as one single device.

The diffractometer device server takes care of implementing the phases listed above 
by talking to its own components. For example, when the beamline supervisor requests
the diffractometer to set itself in transfer phase mode, the diffractometer device server
will drive its own components to reach that phase: light, attenuator, yag positioner will
be moved down; once all devices are down the ln2 cover will be closed; in parallel omega
and other diffractometer motors may need to be moved to its sample mounting position. The
diffractometer device server will free the beamline supervisor from all these details.


   - video camera

   - motors
  
   - lights

   - beamstop

   - aperture


detector
..........

Xaloc uses a Pilatus (ref: ) detector for data acquisition. The detector is mounted on top
of a motorized stage for precisely position it at the required distance.

shutters
..........

sample changer
.................

machine information
....................

other
..........

   - cryo


using jive to access devices
..............................

Expert users can access the instrumenation devices functionality 
directly by calling the corresponding device server commands and
attibutes through the `jive` application.

The following list should help to identify some of the devices in
jive:

  ----------------- ----------------------------
  device name        description
  ----------------- ----------------------------
  bl13/diff/01       Diffratometer dev.server
  ----------------- ----------------------------


