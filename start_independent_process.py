#!/usr/bin/env python3

import subprocess
import os
import sys

# # make the spawned process its own process group
# def change_pgid():
#     def result():
#         os.setpgid(os.getpid())
#     return result


# command = sys.argv[1:]
# # command = ["nohup"] + command
# subprocess.call(command, preexec_fn = change_pgid, close_fds=True)

pid=os.fork()
if pid == 0: # child process
    name = sys.argv[1]
    os.system("nohup {} > /dev/null &".format(name))
    exit()

