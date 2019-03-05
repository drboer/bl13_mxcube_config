+++++++++++++++++++++++++++
Beamline Supervisor
+++++++++++++++++++++++++++

-----------
Description
-----------
The beamline supervisor device server is in charge of supervising
the combined operation of high level beamline instruments.

Four beamline phases (states) are defined and controlled by the
beamline supervisor. The beamline supervisor will control all
the instruments involved to set the beamline in a certain phase.

* **Transfer phase**:

 All the instruments are set in a safe position to proceed with
 sample mounting or unmounting. Diffractometer is driven to its
 mounting position, cryostream is set to protect samples and a
 mechanism is activated to allow automatic movement of the cryostream
 off/on the sample to allow robot arm trajectory at the moment of the
 transfer.

 The detector is verify to be moved at a safe position for transfer to
 avoid collisions with the sample changer robot arm.

* **Collect phase**

 The diffractometer is set at the position required for data collection.
 The beamstop is moved to protect the detector from direct beam exposure,
 backlight, used for sample viewing is set back to its down position

* **Sample View phase**

 The diffractometer sets the conditions to allow sample viewing. The backlight
 is moved up for sample visualization, beamstop is at a lower position below its
 data collection operation position.

* **Beam View phase** (to be reviewed)

 The diffractometer sets the conditions to allow beam viewing. The YAG screen
 is moved up together with the DUSP element, beamstop is at its lowest position.


:TANGO DS: XalocBeamlineSupervisor/bl13
:Device: bl13/eh/supervisor

This device server runs at `bl13mxcube` host (TANGO 8)

This device server is configured using the properties shown in this table.
Each property is used to initialize several devices (DeviceProxy) or attributes grouped
in two categories: signals and devices. Some attributes are mapped directly between
devices. Some other are used to contruct some more complex logic in the `core.py`
used to define other attributes.

+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| Property        | Attribute    | Type     | Role (Key in core.py) | Dict  (in core.py) | Device             | Attribute                | Type       |
+=================+==============+==========+=======================+====================+====================+==========================+============+
| detector_cover  | DetCoverOpen | Boolean  | detcover_open         | eps_signal_names   | bl13/ct/eps-plc-01 | detcover                 | DevShort   |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| distfluo_in     | DistFluoIn   | Boolean  | distfluo_in           | eps_signal_names   | bl13/ct/eps-plc-01 | distfluo                 | DevShort   |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| cryo_in         | ---          | ---      | cryo_in               | eps_signal_names   | bl13/ct/eps-plc-01 | cry_in                   | DevBoolean |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| cryo_far        | ---          | ---      | cryo_far              | eps_signal_names   | bl13/ct/eps-plc-01 | cry_far                  | DevBoolean |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| cryo_far_ctrl   | ---          | ---      | cryo_far_ctrl         | eps_signal_names   | bl13/ct/eps-plc-01 | DIFF_EH01_01_CRYODIST    | DevShort   |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| detdist         | DetDistance  | DevFloat | detdist               | devnames           | dettaby            | position                 | DevDouble  |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| fshuz_motor     | ---          | ---      | fshuz_motor           | ---                | fshuz              | position                 | DevDouble  |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| cryodist_motor  | CryoPosition | DevFloat | cryodist              | devnames           | cryodist           | position                 | DevDouble  |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| sample_changer  | ---          | ---      | sample_changer        | devnames           | bl13/eh/cats       | ---                      | ---        |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| eps             | ---          | ---      | eps                   | devnames           | bl13/ct/eps-plc-01 | ---                      | ---        |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+
| diffractometer  | ---          | ---      | minidiff              | devnames           | bl13/eh/diff       | ---                      | ---        |
+-----------------+--------------+----------+-----------------------+--------------------+--------------------+--------------------------+------------+

Additional DS attributes are:

    * CryoDistSurveyed (DevBoolean)
    * CurrentPhase (DevString)
    * DetDistanceSafe (DevBoolean)
    * FastShutCollectPosition (DevBoolean)


**Phase definitions**

+------------------+-----------------+----------------+---------+------------+----------+
| Role             | Transfer SAMPLE | Transfer PLATE | Collect | SampleVIew | BeamView |
+==================+=================+================+=========+============+==========+
| distfluo_in      | OUT             | OUT            | -       | -          | -        |
+------------------+-----------------+----------------+---------+------------+----------+
| detcover_open    | CLOSED          | CLOSED         | OPEN    | OPEN       | -        |
+------------------+-----------------+----------------+---------+------------+----------+
| detdist          | SAFE (y=-70)    | SAFE (y=-70)   | -       | -          | -        |
+------------------+-----------------+----------------+---------+------------+----------+
| cryodist_motor   | IN (s=0)        | OUT (s =7)     | -       | -          | -        |
+------------------+-----------------+----------------+---------+------------+----------+
| cryo_far_ctrl    | FALSE           | TRUE           | -       | -          | -        |
+------------------+-----------------+----------------+---------+------------+----------+
| CryoDistSurveyed | TRUE            | FALSE          | -       | -          | -        |
+------------------+-----------------+----------------+---------+------------+----------+
| fshuz_motor      | -               | -              | z=0     | -          | -        |
+------------------+-----------------+----------------+---------+------------+----------+
| diffractometer   | Transfer        | Transfer       | Collect | SampleView | BeamView |
+------------------+-----------------+----------------+---------+------------+----------+
