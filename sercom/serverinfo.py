# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

import os
import re
#import logging

#log = logging.getLogger('sercom.serverinfo')

def getinfo():
    usage = dict()
    f = open('/proc/meminfo', 'r')
    cont = f.readlines()
    data = dict()
    for line in cont:
        scan = re.findall('([^\:]+)[\:\s]+([0-9]+)', line)
        if scan[0][0] in ['MemTotal', 'MemFree', 'Cached']:
            data[scan[0][0]] = scan[0][1]
    f.close()
    cpu = os.popen('w')
    line = cpu.readline()
    cpu.close()
    scan = re.findall('average\:[\s]+([0-9\.]+)\,[\s]+([0-9\.]+)\,[\s]+([0-9\.]+)', line)
    usage['MEM'] = '%3.0f %%' % (100*(1-((float(data['MemFree'])+float(data['Cached']))/float(data['MemTotal']))))
    usage['CPU'] = '%3.0f %%' % (float(scan[0][0])*100)
    usage['CPU5'] = '%3.0f %%' % (float(scan[0][1])*100)
    usage['CPU15'] = '%3.0f %%' % (float(scan[0][2])*100)
    return usage
