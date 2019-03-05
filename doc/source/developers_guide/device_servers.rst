High-level device servers
--------------------------
For the automation of tasks and verification of security conditions, there exist two
special device servers at Xaloc. The first one, the `Xaloc Diffractometer` device server
will drive and coordinate the actions of all components of the diffractometer, i.e.
motors, beamstop, lights, ln2 cover, camera, etc. A second device server, the `Beamline
Supervisor`, is in charge of coordinating the actions of the diffractometer and other
beamline devices like, for example, the detector motorization, the cyrostream
positioning between others.

.. toctree::
   :maxdepth: 1

   diffractometer.rst
   supervisor.rst
