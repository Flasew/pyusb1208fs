from distutils.core import setup, Extension
from Cython.Distutils import build_ext
import numpy


usb1208fs = Extension("usb1208fs",
            sources = ["usb1208fs.pyx"],
            library_dirs = ['.','usr/local/lib'],
            include_dirs = ['.', '..', numpy.get_include(), \
                '/usr/lib64/python/site-packages/Cython/Includes'],
            libraries = ['usb-1.0', 'mccusb', 'hidapi-libusb', 'm', 'c'])


setup(
    name = '_usb1208fs',
    version = '0.1',
    description = "Python drivers for Measurement Computing usb1208fs on linux",
    author = 'Weiyang Wang',
    cmdclass={'build_ext': build_ext},
    ext_modules = [usb1208fs],
    platforms=['linux'],
)

