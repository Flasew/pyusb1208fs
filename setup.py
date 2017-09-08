# Filename: setup.py
# Author: Weiyang Wang <wew168@ucsd.edu>
# Description: setup utility for the usb1208fs python library.
#              Based on Warren Jaspers' C drivers.
#              Referenced Guillaume Lepert's python wrapper for USB26xx series.

from distutils.core import setup, Extension
from Cython.Distutils import build_ext
import numpy

classifiers = [
    'Development Status :: 4 - Beta Development Status',
    'Environment :: Console',
    'Intended Audience :: Science/Research',
    'License :: LGPL License',
    'Natural Language :: English',
    'Operating System :: POSIX :: Linux',
    'Programming Language :: C',
    'Programming Language :: Cython',
    'Programming Language :: Python :: 2.7',
    'Topic :: Scientific/Engineering'
]

usb1208fs = Extension("usb1208fs",
            sources = ["usb1208fs/usb1208fs.pyx"],
            library_dirs = ['.','usr/local/lib'],
            include_dirs = ['.', '..', numpy.get_include(), \
                '/usr/lib64/python/site-packages/Cython/Includes'],
            libraries = ['usb-1.0', 'mccusb', 'hidapi-libusb', 'm', 'c'])

setup(
    name = '_usb1208fs',
    version = '0.1.0',
    description = "Python drivers for Measurement Computing USB1208FS on linux",
    author = 'Weiyang Wang',
    author_email = 'wew168@ucsd.edu',
    url = 'https://github.com/Flasew/pyusb1208fs',
    long_description = """Python wrapper of the C-driver of MCC USB1208FS data acquisition card written by Warren Jaspers.

    Functionality includes analog/digital input/output, analog input/output scans, counter, etc. 
    See Warren Jaspers' C-library for more details. 

    This module is mostly just a python wrapper of the original C-driver; some object-orientated
    concepts and python list support were added for a more user-friendly interface. 

    This module requires Warren Jaspers' C drivers to be already installed (see ftp://lx10.tx.ncsu.edu/pub/Linux/drivers/USB/)
    """,
    cmdclass = {'build_ext': build_ext},
    ext_modules = [usb1208fs],
    install_requires = ['numpy', 'cython'],
    platforms=['linux'],
    classifiers = classifiers
)

