#!/usr/bin/env python3

import subprocess
import os
import sys

if len(sys.argv) <= 1:
    exit()

pid=os.fork()
if pid == 0: # child process
    name = sys.argv[1]
    os.system("nohup {} > /dev/null &".format(name))
    exit()

