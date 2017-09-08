# Filename: c1208fs.pxd
# Author: Weiyang Wang
# Date: Sept 5, 2017
# Description: Cython extension definition for python wrapper of the 
#              MCC USB-1208FS DAQ.
# arrays treated as numpy arrays

import numpy as np
cimport numpy as np

# OS headers 
cdef extern from "<stdlib.h>":
    pass
cdef extern from "<stdio.h>":
    pass
cdef extern from "<string.h>":
    pass
cdef extern from "<sys/ioctl.h>":
    pass
cdef extern from "<sys/types.h>":
    pass
cdef extern from "<sys/stat.h>":
    pass
cdef extern from "<asm/types.h>":
    pass
cdef extern from "<fcntl.h>":
    pass
cdef extern from "<unistd.h>":
    pass
cdef extern from "<errno.h>":
    pass
cdef extern from "<math.h>":
    pass
cdef extern from "<string.h>":
    pass

# <libusb-1.0/libusb.h> which is included by pmd.h
cdef extern from "<libusb-1.0/libusb.h>":
    struct libusb_device_handle:
        pass
    struct libusb_context:
        pass
    int LIBUSB_ENDPOINT_OUT
    int LIBUSB_ENDPOINT_IN
    int  libusb_init(libusb_context ** context)
    void libusb_exit(libusb_context * ctx) 
    int  libusb_clear_halt(libusb_device_handle * dev, unsigned char endpoint)
    int  libusb_release_interface (libusb_device_handle * dev, \
        int interface_number)
    void libusb_close(libusb_device_handle * dev_handle)

# pmd.h
cdef extern from "pmd.h":
    libusb_device_handle * usb_device_find_USB_MCC(int productId,
        char * serialID)
    int usb_get_max_packet_size(libusb_device_handle * udev, int endpointNum)


# usb-1208FS.h
cdef extern from "usb-1208FS.h":
    # #define entries
    int USB1208FS_PID 

    int DIO_PORTA
    int DIO_PORTB

    int DIO_DIR_IN 
    int DIO_DIR_OUT

    int OFFSET_ADJUSTMENT  
    int SE_GAIN_ADJUSTMENT 
    int DE_GAIN_ADJUSTMENT 
    int CAL_PIN_VOLTAGE    

    int SYNC           
    int EXT_TRIG_EDGE  
    int UPDATE_MODE 

    int SE_10_00V
    int BP_20_00V  
    int BP_10_00V  
    int BP_5_00V
    int BP_4_00V
    int BP_2_50V
    int BP_2_00V
    int BP_1_25V
    int BP_1_00V

    int AIN_EXECUTION     
    int AIN_TRANSFER_MODE 
    int AIN_TRIGGER     
    int AIN_DEBUG         
    int AIN_GAIN_QUEUE  

    # functions
    # numerical are converted to np equivs, arrays are converted to numpy arrays
    int usbDConfigPort_USB1208FS(libusb_device_handle *udev, 
        np.uint8_t port, np.uint8_t direction);
    int usbDIn_USB1208FS(libusb_device_handle *udev, 
        np.uint8_t port, np.uint8_t* din_value);
    void usbDOut_USB1208FS(libusb_device_handle *udev, 
        np.uint8_t port, np.uint8_t value);

    signed short usbAIn_USB1208FS(libusb_device_handle *udev, 
        np.uint8_t channel, np.uint8_t range);
    void usbAOut_USB1208FS(libusb_device_handle *udev, 
        np.uint8_t channel, np.uint16_t value);
    int usbAOutScan_USB1208FS(libusb_device_handle *udev, 
        np.uint8_t lowchannel, np.uint8_t highchannel, np.uint32_t count,
        np.float32_t * frequency, np.uint16_t data[], np.uint8_t options);
    void usbAOutStop_USB1208FS(libusb_device_handle *udev);
    void usbAInStop_USB1208FS(libusb_device_handle *udev);
    int usbAInScan_USB1208FS(libusb_device_handle *udev, 
        np.uint8_t lowchannel, np.uint8_t highchannel, np.uint32_t count,
        np.float32_t *frequency, np.uint8_t options, np.int16_t data[]);
    int usbAInScan_USB1208FS_SE(libusb_device_handle *udev, 
        np.uint8_t lowchannel, np.uint8_t highchannel, np.uint32_t count,
        np.float32_t *frequency, np.uint8_t options, np.int16_t data[]);
    void usbALoadQueue_USB1208FS(libusb_device_handle *udev, 
        np.uint8_t num, np.uint8_t chan[], np.uint8_t gains[]);

    void usbInitCounter_USB1208FS(libusb_device_handle *udev);
    np.uint32_t usbReadCounter_USB1208FS(libusb_device_handle *udev);

    void usbReadMemory_USB1208FS(libusb_device_handle *udev, 
        np.uint16_t address, np.uint8_t count, np.uint8_t memory[]);
    int usbWriteMemory_USB1208FS(libusb_device_handle *udev, 
        np.uint16_t address, np.uint8_t count, np.uint8_t data[]);
    void usbBlink_USB1208FS(libusb_device_handle *udev);
    int usbReset_USB1208FS(libusb_device_handle *udev);
    np.uint16_t usbGetStatus_USB1208FS(libusb_device_handle *udev);
    void usbSetTrigger_USB1208FS(libusb_device_handle *udev, np.uint8_t type);
    void usbSetSync_USB1208FS(libusb_device_handle *udev, np.uint8_t type);
    void usbGetAll_USB1208FS(libusb_device_handle *udev, np.uint8_t data[]);
    np.float32_t volts_FS(int gain, int num);
    np.float32_t volts_SE(int num);
    int init_USB1208FS(libusb_device_handle *udev);
