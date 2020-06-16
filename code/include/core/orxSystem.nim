##  Orx - Portable Game Engine
##
##  Copyright (c) 2008-2020 Orx-Project
##
##  This software is provided 'as-is', without any express or implied
##  warranty. In no event will the authors be held liable for any damages
##  arising from the use of this software.
##
##  Permission is granted to anyone to use this software for any purpose,
##  including commercial applications, and to alter it and redistribute it
##  freely, subject to the following restrictions:
##
##     1. The origin of this software must not be misrepresented; you must not
##     claim that you wrote the original software. If you use this software
##     in a product, an acknowledgment in the product documentation would be
##     appreciated but is not required.
##
##     2. Altered source versions must be plainly marked as such, and must not be
##     misrepresented as being the original software.
##
##     3. This notice may not be removed or altered from any source
##     distribution.
##
## *
##  @file orxSystem.h
##  @date 25/05/2005
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxSystem
##
##  System file
##  Code that handles system events and timers
##
##  @{
##

import
  orxInclude, math/orxVector

import
  base/orxType, base/orxVersion

## * Event enum
##

type
  orxSYSTEM_EVENT* {.size: sizeof(cint).} = enum
    orxSYSTEM_EVENT_CLOSE = 0, orxSYSTEM_EVENT_FOCUS_GAINED,
    orxSYSTEM_EVENT_FOCUS_LOST, orxSYSTEM_EVENT_BACKGROUND,
    orxSYSTEM_EVENT_FOREGROUND, orxSYSTEM_EVENT_GAME_LOOP_START,
    orxSYSTEM_EVENT_GAME_LOOP_STOP, orxSYSTEM_EVENT_TOUCH_BEGIN,
    orxSYSTEM_EVENT_TOUCH_MOVE, orxSYSTEM_EVENT_TOUCH_END,
    orxSYSTEM_EVENT_ACCELERATE, orxSYSTEM_EVENT_MOTION_SHAKE,
    orxSYSTEM_EVENT_DROP, orxSYSTEM_EVENT_CLIPBOARD, orxSYSTEM_EVENT_NUMBER,
    orxSYSTEM_EVENT_NONE = orxENUM_NONE


## * System event payload
##

type
  INNER_C_STRUCT_orxSystem_94* {.bycopy.} = object
    dTime*: orxDOUBLE
    u32ID*: orxU32
    fX*: orxFLOAT
    fY*: orxFLOAT
    fPressure*: orxFLOAT

  INNER_C_STRUCT_orxSystem_102* {.bycopy.} = object
    dTime*: orxDOUBLE
    vAcceleration*: orxVECTOR

  INNER_C_STRUCT_orxSystem_109* {.bycopy.} = object
    azValueList*: ptr ptr orxCHAR
    u32Number*: orxU32

  INNER_C_STRUCT_orxSystem_117* {.bycopy.} = object
    zValue*: ptr orxCHAR

  INNER_C_UNION_orxSystem_89* {.bycopy.} = object {.union.}
    u32FrameCount*: orxU32     ##  Touch event
    stTouch*: INNER_C_STRUCT_orxSystem_94 ##  Accelerometer event
    stAccelerometer*: INNER_C_STRUCT_orxSystem_102 ##  Drop event
    stDrop*: INNER_C_STRUCT_orxSystem_109 ##  Clipboard event
    stClipboard*: INNER_C_STRUCT_orxSystem_117

  orxSYSTEM_EVENT_PAYLOAD* {.bycopy.} = object
    ano_orxSystem_120*: INNER_C_UNION_orxSystem_89


## * System module setup
##

proc orxSystem_Setup*() {.cdecl, importc: "orxSystem_Setup", dynlib: "liborx.so".}
## * Inits the system module
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSystem_Init*(): orxSTATUS {.cdecl, importc: "orxSystem_Init",
                                 dynlib: "liborx.so".}
## * Exits from the system module
##

proc orxSystem_Exit*() {.cdecl, importc: "orxSystem_Exit", dynlib: "liborx.so".}
## * Gets current time (elapsed from the beginning of the application, in seconds)
##  @return Current time
##

proc orxSystem_GetTime*(): orxDOUBLE {.cdecl, importc: "orxSystem_GetTime",
                                    dynlib: "liborx.so".}
## * Gets real time (in seconds)
##  @return Returns the amount of seconds elapsed since reference time (epoch)
##

proc orxSystem_GetRealTime*(): orxU64 {.cdecl, importc: "orxSystem_GetRealTime",
                                     dynlib: "liborx.so".}
## * Gets current internal system time (in seconds)
##  @return Current internal system time
##

proc orxSystem_GetSystemTime*(): orxDOUBLE {.cdecl,
    importc: "orxSystem_GetSystemTime", dynlib: "liborx.so".}
## * Delay the program for given number of seconds
##  @param[in] _fSeconds             Number of seconds to wait
##

proc orxSystem_Delay*(fSeconds: orxFLOAT) {.cdecl, importc: "orxSystem_Delay",
    dynlib: "liborx.so".}
## * Gets orx version (compiled)
##  @param[out] _pstVersion          Structure to fill with current version
##  @return Compiled version
##

proc orxSystem_GetVersion*(pstVersion: ptr orxVERSION): ptr orxVERSION {.cdecl,
    importc: "orxSystem_GetVersion", dynlib: "liborx.so".}
## * Gets orx version literal (compiled), excluding build number
##  @return Compiled version literal
##

proc orxSystem_GetVersionString*(): ptr orxCHAR {.cdecl,
    importc: "orxSystem_GetVersionString", dynlib: "liborx.so".}
## * Gets orx version literal (compiled), including build number
##  @return Compiled version literal
##

proc orxSystem_GetVersionFullString*(): ptr orxCHAR {.cdecl,
    importc: "orxSystem_GetVersionFullString", dynlib: "liborx.so".}
## * Gets orx version absolute numeric value (compiled)
##  @return Absolute numeric value of compiled version
##

proc orxSystem_GetVersionNumeric*(): orxU32 {.cdecl,
    importc: "orxSystem_GetVersionNumeric", dynlib: "liborx.so".}
## * Gets clipboard's content
##  @return Clipboard's content / orxNULL, valid until next call to orxSystem_GetClipboard/orxSystem_SetClipboard
##

proc orxSystem_GetClipboard*(): ptr orxCHAR {.cdecl,
    importc: "orxSystem_GetClipboard", dynlib: "liborx.so".}
## * Sets clipboard's content
##  @param[in] _zValue               Value to set in the clipboard, orxNULL to clear
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSystem_SetClipboard*(zValue: ptr orxCHAR): orxSTATUS {.cdecl,
    importc: "orxSystem_SetClipboard", dynlib: "liborx.so".}
## * @}
