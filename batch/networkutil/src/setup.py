from distutils.core import setup
import py2exe

dll_excludes=['w9xpopen.exe']
setup(console=[	'networkcheck.py',
		'pingserver.py',
		'mail.py',
		])


