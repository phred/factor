! Copyright (C) 2017 Benjamin Pollack.
! See http://factorcode.org/license.txt for BSD license.
USING: alien.syntax windows.types ;
IN: windows.shcore

LIBRARY: shcore

ENUM: MONITOR_DPI_TYPE
    MDT_EFFECTIVE_DPI
    MDT_ANGULAR_DPI
    MDT_RAW_DPI
    { MDT_DEFAULT 0 } ;

ENUM: PROCESS_DPI_AWARENESS
    { PROCESS_DPI_UNAWARE 0 }
    { PROCESS_SYSTEM_DPI_AWARE 1 }
    { PROCESS_PER_MONITOR_DPI_AWARE 2 } ;

ENUM: SCALE_CHANGE_FLAGS
    { SCF_VALUE_NONE 0 }
    { SCF_SCALE 1 }
    { SCF_PHYSICAL 2 } ;

FUNCTION: HRESULT GetDpiForMonitor ( HMONITOR hMonitor, MONITOR_DPI_TYPE dpiType, UINT* dpiX, UINT *dpiY )

ENUM: DEVICE_SCALE_FACTOR
    { DEVICE_SCALE_FACTOR_INVALID 0 }
    { SCALE_100_PERCENT 100 }
    { SCALE_120_PERCENT 120 }
    { SCALE_125_PERCENT 125 }
    { SCALE_140_PERCENT 140 }
    { SCALE_150_PERCENT 150 }
    { SCALE_160_PERCENT 160 }
    { SCALE_175_PERCENT 175 }
    { SCALE_180_PERCENT 180 }
    { SCALE_200_PERCENT 200 }
    { SCALE_225_PERCENT 223 }
    { SCALE_250_PERCENT 250 }
    { SCALE_300_PERCENT 300 }
    { SCALE_350_PERCENT 350 }
    { SCALE_400_PERCENT 400 }
    { SCALE_450_PERCENT 450 }
    { SCALE_500_PERCENT 500 } ;

FUNCTION: HRESULT GetScaleFactorForMonitor (
    HMONITOR            hMon,
    DEVICE_SCALE_FACTOR *pScale
)

FUNCTION: HRESULT RegisterScaleChangeEvent (
    HANDLE    hEvent,
    DWORD_PTR *pdwCookie
)

ENUM: DISPLAY_DEVICE_TYPE
    { DEVICE_PRIMARY 0 }
    { DEVICE_IMMERSIVE 1 } ;


FUNCTION: HRESULT RevokeScaleChangeNotifications (
    DISPLAY_DEVICE_TYPE displayDevice,
    DWORD               dwCookie
)

FUNCTION: HRESULT UnregisterScaleChangeEvent (
    DWORD_PTR dwCookie
)

FUNCTION: HRESULT GetProcessDpiAwareness ( HANDLE hprocess, PROCESS_DPI_AWARENESS* value )
FUNCTION: HRESULT SetProcessDpiAwareness ( PROCESS_DPI_AWARENESS value )

ENUM: SHELL_UI_COMPONENT
    { SHELL_UI_COMPONENT_TASKBARS 0 }
    { SHELL_UI_COMPONENT_NOTIFICATIONAREA 1 }
    { SHELL_UI_COMPONENT_DESKBAND 2 } ;