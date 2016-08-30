#!/bin/python
#
import os, sys

dirs = [d for d in os.listdir('.') if os.path.isdir(d)]

command = """
.PHONY: {target}
{target}: {dep}
	@echo "building image flow123d/{target}"
	docker build --tag flow123d/{target:30s}     {target}
""".lstrip()

print """
# Autogenetared script for building docker images
#   generated using makefile.py 
#   python makefile.py  > makefile

""".lstrip()


target = 'all'
dep = ' '.join(dirs)
print command.format(**locals())


dep = ''
for target in dirs:
    print command.format(**locals())
