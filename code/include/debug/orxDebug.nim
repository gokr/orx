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
##  @file orxDebug.h
##  @date 10/12/2003
##  @author iarwain@orx-project.org
##
##  @todo
##  - Add graphical debug from outside, using a shared debug info array
##  - Enhance logging, use of different log levels / colors
##
## *
##  @addtogroup orxDebug
##
##  Debug module
##  Module used to output debug info and assert code
##
##  @{
##

#import
#  orxInclude

import
  base/[orxType, orxVersion, orxDecl]

##  *** orxDEBUG flags ***

const
  orxDEBUG_KU32_STATIC_FLAG_NONE* = 0x00000000
  orxDEBUG_KU32_STATIC_FLAG_TIMESTAMP* = 0x00000001
  orxDEBUG_KU32_STATIC_FLAG_FULL_TIMESTAMP* = 0x00000002
  orxDEBUG_KU32_STATIC_FLAG_TYPE* = 0x00000004
  orxDEBUG_KU32_STATIC_FLAG_TAGGED* = 0x00000008
  orxDEBUG_KU32_STATIC_FLAG_FILE* = 0x00000010
  orxDEBUG_KU32_STATIC_FLAG_TERMINAL* = 0x00000020
  orxDEBUG_KU32_STATIC_FLAG_CONSOLE* = 0x00000040
  orxDEBUG_KU32_STATIC_FLAG_CALLBACK* = 0x00000080
  orxDEBUG_KU32_STATIC_MASK_DEFAULT* = 0x000000F5
  orxDEBUG_KU32_STATIC_MASK_DEBUG* = 0x000000BD
  orxDEBUG_KU32_STATIC_MASK_USER_ALL* = 0x0FFFFFFF

##  *** Misc ***

const
  orxDEBUG_KZ_DEFAULT_DEBUG_FILE* = "orx-debug.log"
  orxDEBUG_KZ_DEFAULT_LOG_FILE* = "orx.log"
  orxDEBUG_KZ_DEFAULT_LOG_SUFFIX* = ".log"
  orxDEBUG_KZ_DEFAULT_DEBUG_SUFFIX* = "-debug.log"

##  Debug levels

type
  orxDEBUG_LEVEL* {.size: sizeof(cint).} = enum
    orxDEBUG_LEVEL_ANIM = 0,    ## *< Anim Debug
    orxDEBUG_LEVEL_CONFIG,    ## *< Config Debug
    orxDEBUG_LEVEL_CLOCK,     ## *< Clock Debug
    orxDEBUG_LEVEL_DISPLAY,   ## *< Display Debug
    orxDEBUG_LEVEL_FILE,      ## *< File Debug
    orxDEBUG_LEVEL_INPUT,     ## *< Input Debug
    orxDEBUG_LEVEL_JOYSTICK,  ## *< Joystick Debug
    orxDEBUG_LEVEL_KEYBOARD,  ## *< Keyboard Debug
    orxDEBUG_LEVEL_MEMORY,    ## *< Memory Debug
    orxDEBUG_LEVEL_MOUSE,     ## *< Mouse Debug
    orxDEBUG_LEVEL_OBJECT,    ## *< Object Debug
    orxDEBUG_LEVEL_PARAM,     ## *< Param Debug
    orxDEBUG_LEVEL_PHYSICS,   ## *< Physics Debug
    orxDEBUG_LEVEL_PLUGIN,    ## *< Plug-in Debug
    orxDEBUG_LEVEL_PROFILER,  ## *< Profiler Debug
    orxDEBUG_LEVEL_RENDER,    ## *< Render Debug
    orxDEBUG_LEVEL_SCREENSHOT, ## *< Screenshot Debug
    orxDEBUG_LEVEL_SOUND,     ## *< Sound Debug
    orxDEBUG_LEVEL_SYSTEM,    ## *< System Debug
    orxDEBUG_LEVEL_TIMER,     ## *< Timer Debug
    orxDEBUG_LEVEL_LOG,       ## *< Log Debug
    orxDEBUG_LEVEL_ASSERT,    ## *< Assert Debug
    orxDEBUG_LEVEL_USER,      ## *< User Debug
    orxDEBUG_LEVEL_NUMBER, orxDEBUG_LEVEL_MAX_NUMBER = 32, orxDEBUG_LEVEL_ALL = 0xFFFFFFFE, ## *< All Debugs
    orxDEBUG_LEVEL_NONE = orxENUM_NONE



# Hack to get orxLOG to compile
proc orxLOG(s: string) =
  echo(s)

##  Log callback function

type
  orxDEBUG_CALLBACK_FUNCTION* = proc (eLevel: orxDEBUG_LEVEL; zFunction: ptr orxCHAR;
                                   zFile: ptr orxCHAR; u32Line: orxU32;
                                   zLog: ptr orxCHAR): orxSTATUS {.cdecl.}

##  *** Debug Macros ***

when defined(DEBUG):
  ##  End platform specific
  template orxDEBUG_ENABLE_LEVEL*(LEVEL, ENABLE: untyped): untyped =
    orxDebug_EnableLevel(LEVEL, ENABLE)

  template orxDEBUG_IS_LEVEL_ENABLED*(LEVEL: untyped): untyped =
    orxDebug_IsLevelEnabled(LEVEL)

  template orxDEBUG_SET_FLAGS*(SET, UNSET: untyped): untyped =
    orxDebug_SetFlagsInternal(SET, UNSET)

  template orxDEBUG_GET_FLAGS*(): untyped =
    orxDebug_GetFlagsInternal()

  template orxDEBUG_SET_LOG_CALLBACK*(CALLBACK: untyped): untyped =
    orxDebug_SetLogCallback(CALLBACK)

  ##  Break
  template orxBREAK*(): untyped =
    orxDebug_Break()

  ##  Files
  template orxDEBUG_SETDEBUGFILE*(FILE: untyped): untyped =
    orxDebug_SetDebugFile(FILE)

  template orxDEBUG_SETLOGFILE*(FILE: untyped): untyped =
    orxDebug_SetLogFile(FILE)

  template orxDEBUG_SETBASEFILENAME*(FILE: untyped): void =
    var zBuffer: array[512, orxCHAR]
    zBuffer[511] = orxCHAR_NULL
    strncpy(zBuffer, FILE, 256)
    strncat(zBuffer, orxDEBUG_KZ_DEFAULT_DEBUG_SUFFIX, 255)
    orxDebug_SetDebugFile(zBuffer)
    strncpy(zBuffer, FILE, 256)
    strncat(zBuffer, orxDEBUG_KZ_DEFAULT_LOG_SUFFIX, 255)
    orxDebug_SetLogFile(zBuffer)

  ##  Assert
else:
  template orxDEBUG_ENABLE_LEVEL*(LEVEL, ENABLE: untyped): untyped =
    orxDebug_EnableLevel(LEVEL, ENABLE)

  template orxDEBUG_IS_LEVEL_ENABLED*(LEVEL: untyped): untyped =
    orxDebug_IsLevelEnabled(LEVEL)

  template orxDEBUG_SET_FLAGS*(SET, UNSET: untyped): untyped =
    orxDebug_SetFlagsInternal(SET, UNSET)

  template orxDEBUG_GET_FLAGS*(): untyped =
    orxDebug_GetFlagsInternal()

  template orxDEBUG_SET_LOG_CALLBACK*(CALLBACK: untyped): untyped =
    orxDebug_SetLogCallback(CALLBACK)

  ##  Break
  template orxBREAK*(): void =
    nil

  ##  File
  template orxDEBUG_SETDEBUGFILE*(FILE: untyped): void =
    nil

  template orxDEBUG_SETLOGFILE*(FILE: untyped): untyped =
    orxDebug_SetLogFile(FILE)

  template orxDEBUG_SETBASEFILENAME*(FILE: untyped): void =
    var zBuffer: array[512, orxCHAR]
    zBuffer[511] = orxCHAR_NULL
    strncpy(zBuffer, FILE, 256)
    strncat(zBuffer, orxDEBUG_KZ_DEFAULT_LOG_SUFFIX, 255)
    orxDebug_SetLogFile(zBuffer)


## ***************************************************************************
##  *** Debug defines. ***

const
  orxDEBUG_KS32_BUFFER_OUTPUT_SIZE* = 2048

## ***************************************************************************
##  *** Functions ***
## * Inits the debug module
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDebug_InitInternal*(): orxSTATUS {.cdecl, importc: "_orxDebug_Init",
                                dynlib: "liborx.so".}
## * Exits from the debug module

proc orxDebug_ExitInternal*() {.cdecl, importc: "_orxDebug_Exit", dynlib: "liborx.so".}
## * Logs given debug text
##  @param[in]   _eLevel                       Debug level associated with this output
##  @param[in]   _zFunction                    Calling function name
##  @param[in]   _zFile                        Calling file name
##  @param[in]   _u32Line                      Calling file line
##  @param[in]   _zFormat                      Printf formatted text
##

proc orxDebug_Log*(eLevel: orxDEBUG_LEVEL; zFunction: ptr orxCHAR; zFile: ptr orxCHAR;
                  u32Line: orxU32; zFormat: ptr orxCHAR) {.varargs, cdecl,
    importc: "_orxDebug_Log", dynlib: "liborx.so".}
## * Enables/disables a given log level
##  @param[in]   _eLevel                       Debug level to enable/disable
##  @param[in]   _bEnable                      Enable / disable
##

proc orxDebug_EnableLevel*(eLevel: orxDEBUG_LEVEL; bEnable: orxBOOL) {.cdecl,
    importc: "_orxDebug_EnableLevel", dynlib: "liborx.so".}
## * Is a given log level enabled?
##  @param[in]   _eLevel                       Concerned debug level
##

proc orxDebug_IsLevelEnabled*(eLevel: orxDEBUG_LEVEL): orxBOOL {.cdecl,
    importc: "_orxDebug_IsLevelEnabled", dynlib: "liborx.so".}
## * Sets current debug flags
##  @param[in]   _u32Add                       Flags to add
##  @param[in]   _u32Remove                    Flags to remove
##

proc orxDebug_SetFlagsInternal*(u32Add: orxU32; u32Remove: orxU32) {.cdecl,
    importc: "_orxDebug_SetFlags", dynlib: "liborx.so".}
## * Gets current debug flags
##  @return Current debug flags
##

proc orxDebug_GetFlagsInternal*(): orxU32 {.cdecl, importc: "_orxDebug_GetFlags",
                                 dynlib: "liborx.so".}
## * Software break function

proc orxDebug_Break*() {.cdecl, importc: "_orxDebug_Break", dynlib: "liborx.so".}
## * Sets debug file name
##  @param[in]   _zFileName                    Debug file name
##

proc orxDebug_SetDebugFile*(zFileName: ptr orxCHAR) {.cdecl,
    importc: "_orxDebug_SetDebugFile", dynlib: "liborx.so".}
## * Sets log file name
##  @param[in]   _zFileName                    Log file name
##

proc orxDebug_SetLogFile*(zFileName: ptr orxCHAR) {.cdecl,
    importc: "_orxDebug_SetLogFile", dynlib: "liborx.so".}
## * Sets log callback function, if the callback returns orxSTATUS_FAILURE, the log entry will be entirely inhibited
##  @param[in]   _pfnLogCallback                Log callback function, nil to remove it
##

proc orxDebug_SetLogCallback*(pfnLogCallback: orxDEBUG_CALLBACK_FUNCTION) {.cdecl,
    importc: "_orxDebug_SetLogCallback", dynlib: "liborx.so".}
## * @}



template orxDEBUG_INIT*(): void =
  var u32DebugFlags: orxU32
  discard orxDebug_InitInternal()
  u32DebugFlags = orxDebug_GetFlagsInternal()
  orxDebug_SetFlagsInternal(orxDEBUG_KU32_STATIC_MASK_DEBUG, orxDEBUG_KU32_STATIC_MASK_USER_ALL)
  if orxSystem_GetVersionNumeric().int64 < VERSION:
    orxLOG("The version of the runtime library [" & $orxSystem_GetVersionFullString() &
      "] is older than the version used when compiling this program [" & VERSION_FULL_STRING & "].\n\nProblems will likely ensue!")
  elif orxSystem_GetVersionNumeric().int64 > VERSION:
    orxLOG("The version of the runtime library [" & $orxSystem_GetVersionFullString() &
      "] is more recent than the version used when compiling this program [" & VERSION_FULL_STRING & "].\n\nProblems may arise due to possible incompatibilities!")
  orxDebug_SetFlagsInternal(u32DebugFlags, orxDEBUG_KU32_STATIC_MASK_USER_ALL)

template orxDEBUG_EXIT*(): untyped =
  orxDebug_ExitInternal()

