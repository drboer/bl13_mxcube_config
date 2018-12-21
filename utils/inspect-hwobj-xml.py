import xml.etree.ElementTree
import os


class HwObjSkeleton(object):

    def __init__(self, xml_filename):
        self.root = xml.etree.ElementTree.parse(xml_filename).getroot()
        self.category = str(self.root.tag)
        self.klass = self.root.attrib['class']
        self.xml_filename = os.path.basename(xml_filename)

        self.objects = [a.get('role') for a in self.root.findall('object')]
        self.channels = [a.get('name') for a in self.root.findall('channel')]
        self.commands = [a.get('name') for a in self.root.findall('command')]
        self.properties = [c.tag for c in self.root]
        token = lambda x: x not in ['object', 'channel', 'command']
        self.properties = filter(token, self.properties)

    def __str__(self):
        _str = 'Class: {}\n'.format(self.klass)
        _str += 'Type: {}\n'.format(self.category)
        _str += 'Configuration: {}\n\n'.format(self.xml_filename)
        _str += 'objects(roles):\n----------------\n'
        _str += '\n'.join(['* {}'.format(str(s)) for s in self.objects])
        _str += '\n\nchannels(names):\n----------------\n'
        _str += '\n'.join(['* {}'.format(str(s)) for s in self.channels])
        _str += '\n\ncommand(names):\n----------------\n'
        _str += '\n'.join(['* {}'.format(str(s)) for s in self.commands])
        _str += '\n\nproperties:\n----------------\n'
        _str += '\n'.join(['* {}'.format(str(s)) for s in self.properties])
        return _str


if __name__ == "__main__":
    #print  HwObjSkeleton('../bl13_config/hardware_objects.xml/cats.xml')
    #hwobj = HwObjSkeleton('../bl13_config/hardware_objects.xml/cats.xml')
    # print hwobj.category
    # print hwobj.klass
    hwobj = HwObjSkeleton('../bl13_config/hardware_objects.xml/mini-diff.xml')
    print hwobj