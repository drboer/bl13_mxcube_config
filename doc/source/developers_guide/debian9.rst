++++++++++++++++++++++++++
Debian 9 Installation log
++++++++++++++++++++++++++

#. Login to `ctbl1301` machine (Debian9 / Tango9)

#. Ensure the local ALBA repositories are configured (by default by IT Systems):

   * /etc/apt/sources.list

       deb [arch=amd64] http://cobbler.cells.es/cblr/repo_mirror/Debian9-stretch-updates stretch-updates main contrib non-free
       deb [arch=amd64] http://cobbler.cells.es/cblr/repo_mirror/Debian9-stretch-security stretch/updates main contrib non-free
       deb [arch=amd64] http://cobbler.cells.es/cblr/repo_mirror/Debian9-stretch-main stretch main contrib non-free

   * /etc/apt/sources.list.d/controls_aptly.list

       deb http://debrepos.cells.es stretch production staging ugly
       deb-src http://debrepos.cells.es stretch production staging

#. Backup tango DB:

    Login to `tbl1301` and execute::

        mysqldump -u root -p tango > /beamlines/bl13/controls/backups/sardana/20180917_11:35_BL13_tangodb_3.16.sql

#. Install packages required for base MXCuBE in Debian9/Qt4 linux-image-4.9.0-6-amd64::

    sudo apt-get install -y git (Installed) | 1:2.11.0-3+deb9u3
    sudo apt-get install -y vim (Installed) | 2:8.0.0197-4+deb9u1
    sudo apt-get install -y python-qt4 (Installed) | 4.11.4+dfsg-2+b1
    sudo apt-get install -y python-gevent | .../python-greenlet_0.4.11-1_amd64.deb | .../python-gevent_1.1.2-1_amd64.deb
    sudo apt-get install -y python-louie | .../python-louie_1.1-2.1_all.deb
    sudo apt-get install -y python-jsonpickle | .../python-jsonpickle_0.9.3-2_all.deb
    sudo apt-get install -y python-numpy (Installed) | 1:1.12.1-3
    sudo apt-get install -y python-scipy (Installed) | 0.18.1-2
    sudo apt-get install -y python-matplotlib (Installed) | 2.0.0+dfsg1-2
    sudo apt-get install -y python-suds | .../python-suds_0.7~git20150727.94664dd-3_all.deb
    sudo apt-get install -y pymca | 5.1.3+dfsg-1
    sudo apt-get install -y python-yaml (Installed) | 3.12-1
    sudo apt-get install -y python-pydispatch | .../python-pydispatch_2.0.5-1_all.deb
    sudo apt-get install -y python-enum34 (Installed) | 1.1.6-1

#. Install ALBA control system::

    sudo apt-get install -y python-sardana | 2.2.2-3

This install many additional packages of interest, for instance::

    python-itango all 0.1.6-1
    python-pytango amd64 9.2.0-2
    python-tango amd64 9.2.0-2

#. Set TangoDatabase host to `tbl1301.cells.es`.
