#!/usr/bin/env python

import subprocess

terminal = ['gnome-terminal']
for host in ('server1', 'server2'):
    terminal.extend(['--tab', '-e', '''
        bash -c '
            echo "%(host)s$" 
            ssh -t %(host)s 
            read
        '
    ''' % locals()])
subprocess.call(terminal)
