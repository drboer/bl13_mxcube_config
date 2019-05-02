+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
MXCuBE in a Docker container (Debian9_Qt4)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

A docker image is also supplied within the mxcube collaboration in order
to test the application in a controlled environment. This notes are not up-to-date
and have to be taken only as a guide.

The docker files can be found in the repository::

    https://github.com/mxcube/mx3docker

----------------
Pre-configuraton
----------------

Create an `xauth` file for docker client::

    export XAUTH=/tmp/.docker.xauth
    xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

Building the image::

    docker build -t mx3_deb9_qt4 /home/jandreu/Development/MXCuBE/mx3docker/dev/Debian9_qt4/

------------------
Run the image
------------------

    #) Create an interactive container::

        docker run -it -v /home/jandreu/Development/MXCuBE/mxcube:/MXCuBE/mxcube --env MXCUBE_ROOT=/MXCuBE/mxcube --env CUSTOM_HARDWARE_OBJECTS_PATH=/MXCuBE/mxcube/HardwareRepository/HardwareObjects --env CUSTOM_BRICKS_PATH=/MXCuBE/mxcube/BlissFramework/Bricks --env HARDWARE_REPOSITORY_SERVER=/MXCuBE/mxcube/ExampleFiles/HardwareObjects.xml --env MXCUBE_GUI_PATH=/MXCuBE/mxcube/ExampleFiles --env USER=sicilia --env INSTITUTE=ALBA --env XSOCK=/tmp/.X11-unix --env XAUTH=/tmp/.docker.xauth --env APP_NAME=api_test --name mxcube2_qt4 -e DISPLAY=:0 -e QT_X11_NO_MITSHM=1 -e XAUTHORITY=$XAUTH -v /tmp/.X11-unix:/tmp/.X11-unix mx3_deb9_qt4:latest

    #) Create an application container::

        docker run --entrypoint /MXCuBE/mxcube/bin/mxcube -v /home/jandreu/Development/MXCuBE/mxcube:/MXCuBE/mxcube --env MXCUBE_ROOT=/MXCuBE/mxcube --env CUSTOM_HARDWARE_OBJECTS_PATH=/MXCuBE/mxcube/HardwareRepository/HardwareObjects --env CUSTOM_BRICKS_PATH=/MXCuBE/mxcube/BlissFramework/Bricks --env HARDWARE_REPOSITORY_SERVER=/MXCuBE/mxcube/ExampleFiles/HardwareObjects.xml --env MXCUBE_GUI_PATH=/MXCuBE/mxcube/ExampleFiles/ --env USER=sicilia --env INSTITUTE=ALBA --env XSOCK=/tmp/.X11-unix --env XAUTH=/tmp/.docker.xauth --name mxcube2_qt4-app -e DISPLAY=:0 -e QT_X11_NO_MITSHM=1 -e XAUTHORITY=$XAUTH -v /tmp/.X11-unix:/tmp/.X11-unix mx3_deb9_qt4:latest

---------------------
Environment variables
---------------------

    --bricksDir  ->  CUSTOM_BRICKS_PATH
    --hardwareRepository  ->  HARDWARE_REPOSITORY_SERVER
    --hardwareObjectsDirs  ->  CUSTOM_HARDWARE_OBJECTS_PATH

    * Standard locations must be added automatically
    * Specific site locations can be added manually (using th SITE environmental variable)

-----------
Application
-----------

The final application depends on two things:

    * The configuration file (yml) for the UI.
    * The hardware repository server contents (xml files).

----
Demo
----
run::

    docker run -d -e HARDWARE_REPOSITORY_SERVER=/MXCuBE/mxcube/ExampleFiles/HardwareObjects.xml -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix mx3_deb9_qt4_master_demo
