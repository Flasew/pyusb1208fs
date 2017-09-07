from distutils.core import setup, Extension
from Cython.Distutils import build_ext
import numpy


usb1208fs = Extension("wrapper",
            sources = ["1208fs.pyx", "mccdaq-extra.c"],
            library_dirs = ['.','usr/local/lib'],
            include_dirs = ['.', '..', numpy.get_include(), \
                '/usr/lib64/python/site-packages/Cython/Includes'],
            libraries = ['usb-1.0', 'mccusb', 'hidapi-libusb', 'm', 'c'])


setup(
    name = 'usb1208fs',
    version = '0.1',
    description = "Python drivers for Measurement Computing usb1208fs on linux",
    author = 'Weiyang Wang',
    cmdclass={'build_ext': build_ext},
    ext_modules = [usb1208fs],
    platforms=['linux'],
    classifiers = classifiers
)

#A Python driver for MCCDAQ's USB2600 data acquisition devices, providing: 

    #- a Cython wrapper to Warren Jasper's original Linux MCCDAQ driver (available here_),

    #- an object-oriented interface build on top of the Cython wrapper.

    #The driver includes advanced functionalities for analog input and output scans of arbitrary length and synchronous analog input/output scanning.

    #Get in touch if anybody is interested in adding support for other MCC devices.

    #.. _here: ftp://lx10.tx.ncsu.edu/pub/Linux/drivers/USB
    #""",
