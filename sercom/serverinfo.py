# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:
import string
import os
import re
#import logging

#log = logging.getLogger('sercom.serverinfo')

def getinfo():
    usage = dict()
    ps_process = os.popen("ps aux | awk '{cpu +=$3}; {mem +=$4}; END {print cpu,mem}'")
    cpu,mem = string.split(ps_process.readline())
    ps_process.close()
    usage['MEM'] = '%s%%' % mem
    usage['CPU'] = '%s%%' % cpu
    return usage
