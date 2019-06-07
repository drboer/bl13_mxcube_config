#!/usr/bin/env python

from __future__ import print_function

import tango
import ldap
import sardana
import taurus
import gevent
import numpy
import scipy
import matplotlib
import suds
import yaml
import jsonpickle
import pydispatch
import PIL
import enum

from lxml import etree
from PyQt4.QtCore import QT_VERSION_STR


print("+++++++++++++++++++++++++++++")
print("MXCuBE dependencies versions:")
print("+++++++++++++++++++++++++++++")
print("(py)tango: {}".format(tango.__version__))
print("sardana: {}".format(sardana.Release.version))
print("taurus: {}".format(taurus.Release.version))
print("gevent: {}".format(gevent.__version__))
print("pydispatch: {}".format(pydispatch.__version__))
print("PyQt: {}".format(QT_VERSION_STR))
print("PIL: {}".format(PIL.__version__))
print("numpy: {}".format(numpy.__version__))
print("scipy: {}".format(scipy.__version__))
print("matplotlib: {}".format(matplotlib.__version__))
print("enum: {}".format(enum.version))
print("lxml: {}".format(etree.LXML_VERSION))
print("ldap: {}".format(ldap.__version__))
print("suds: {}".format(suds.__version__))
print("yaml: {}".format(yaml.__version__))
print("jsonpickle: {}".format(jsonpickle.__version__))
