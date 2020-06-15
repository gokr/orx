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
##  @file orxConsole.h
##  @date 13/08/2012
##  @author iarwain@orx-project.org
##
##
## *
##  @addtogroup orxConsole
##
##  Console module
##  Module that can execute consoles and log info at runtime
##  @{
##

import
  orxInclude, display/orxFont, io/orxInput

## * Inputs
##

const
  orxCONSOLE_KZ_INPUT_SET* = "-=ConsoleSet=-"
  orxCONSOLE_KZ_INPUT_TOGGLE* = "Toggle"
  orxCONSOLE_KZ_INPUT_AUTOCOMPLETE* = "AutoComplete"
  orxCONSOLE_KZ_INPUT_DELETE* = "Delete"
  orxCONSOLE_KZ_INPUT_DELETE_AFTER* = "DeleteAfter"
  orxCONSOLE_KZ_INPUT_TOGGLE_MODE* = "ToggleMode"
  orxCONSOLE_KZ_INPUT_ENTER* = "Enter"
  orxCONSOLE_KZ_INPUT_PREVIOUS* = "Previous"
  orxCONSOLE_KZ_INPUT_NEXT* = "Next"
  orxCONSOLE_KZ_INPUT_LEFT* = "Left"
  orxCONSOLE_KZ_INPUT_RIGHT* = "Right"
  orxCONSOLE_KZ_INPUT_START* = "Start"
  orxCONSOLE_KZ_INPUT_END* = "End"
  orxCONSOLE_KZ_INPUT_PASTE* = "Paste"
  orxCONSOLE_KZ_INPUT_SCROLL_DOWN* = "ScrollDown"
  orxCONSOLE_KZ_INPUT_SCROLL_UP* = "ScrollUp"

## * Console module setup
##

proc orxConsole_Setup*() {.cdecl, importcpp: "orxConsole_Setup(@)",
                         dynlib: "liborx.so".}
## * Inits the console module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConsole_Init*(): orxSTATUS {.cdecl, importcpp: "orxConsole_Init(@)",
                                  dynlib: "liborx.so".}
## * Exits from the console module
##

proc orxConsole_Exit*() {.cdecl, importcpp: "orxConsole_Exit(@)", dynlib: "liborx.so".}
## * Enables/disables the console
##  @param[in]   _bEnable      Enable / disable
##

proc orxConsole_Enable*(bEnable: orxBOOL) {.cdecl,
    importcpp: "orxConsole_Enable(@)", dynlib: "liborx.so".}
## * Is the console enabled?
##  @return orxTRUE if enabled, orxFALSE otherwise
##

proc orxConsole_IsEnabled*(): orxBOOL {.cdecl, importcpp: "orxConsole_IsEnabled(@)",
                                     dynlib: "liborx.so".}
## * Is the console input in insert mode?
##  @return orxTRUE if insert mode, orxFALSE otherwise (overwrite mode)
##

proc orxConsole_IsInsertMode*(): orxBOOL {.cdecl, importcpp: "orxConsole_IsInsertMode(@)",
                                        dynlib: "liborx.so".}
## * Sets the console toggle
##  @param[in] _eInputType      Type of input peripheral
##  @param[in] _eInputID        ID of button/key/axis
##  @param[in] _eInputMode      Mode of input
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConsole_SetToggle*(eInputType: orxINPUT_TYPE; eInputID: orxENUM;
                          eInputMode: orxINPUT_MODE): orxSTATUS {.cdecl,
    importcpp: "orxConsole_SetToggle(@)", dynlib: "liborx.so".}
## * Logs to the console
##  @param[in]   _zText        Text to log
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConsole_Log*(zText: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxConsole_Log(@)", dynlib: "liborx.so".}
## * Sets the console font
##  @param[in]   _pstFont      Font to use
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConsole_SetFont*(pstFont: ptr orxFONT): orxSTATUS {.cdecl,
    importcpp: "orxConsole_SetFont(@)", dynlib: "liborx.so".}
## * Gets the console font
##  @return Current in-use font, orxNULL
##

proc orxConsole_GetFont*(): ptr orxFONT {.cdecl, importcpp: "orxConsole_GetFont(@)",
                                      dynlib: "liborx.so".}
## * Sets the console log line length
##  @param[in]   _u32LineLength Line length to use
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConsole_SetLogLineLength*(u32LineLength: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxConsole_SetLogLineLength(@)", dynlib: "liborx.so".}
## * Gets the console log line length
##  @return Console log line length
##

proc orxConsole_GetLogLineLength*(): orxU32 {.cdecl,
    importcpp: "orxConsole_GetLogLineLength(@)", dynlib: "liborx.so".}
## * Gets current completions count
##  @param[out]  _pu32MaxLength Max completion length, orxNULL to ignore
##  @return Current completions count
##

proc orxConsole_GetCompletionCount*(pu32MaxLength: ptr orxU32): orxU32 {.cdecl,
    importcpp: "orxConsole_GetCompletionCount(@)", dynlib: "liborx.so".}
## * Gets completion
##  @param[in]   _u32Index     Index of the active completion
##  @param[out]  _pbActive     Is completion active, orxNULL to ignore
##  @return Completion string if found, orxSTRING_EMPTY otherwise
##

proc orxConsole_GetCompletion*(u32Index: orxU32; pbActive: ptr orxBOOL): ptr orxCHAR {.
    cdecl, importcpp: "orxConsole_GetCompletion(@)", dynlib: "liborx.so".}
## * Gets log line from the end (trail), using internal offset
##  @param[in]   _u32TrailLineIndex Index of the line starting from end
##  @return orxTRING / orxSTRING_EMPTY
##

proc orxConsole_GetTrailLogLine*(u32TrailLineIndex: orxU32): ptr orxCHAR {.cdecl,
    importcpp: "orxConsole_GetTrailLogLine(@)", dynlib: "liborx.so".}
## * Gets log line offset from the end
##  @return Log line offset from the end
##

proc orxConsole_GetTrailLogLineOffset*(): orxU32 {.cdecl,
    importcpp: "orxConsole_GetTrailLogLineOffset(@)", dynlib: "liborx.so".}
## * Gets input text
##  @param[out]  _pu32CursorIndex Index (ie. character position) of the cursor (any character past it has not been validated)
##  @return orxTRING / orxSTRING_EMPTY
##

proc orxConsole_GetInput*(pu32CursorIndex: ptr orxU32): ptr orxCHAR {.cdecl,
    importcpp: "orxConsole_GetInput(@)", dynlib: "liborx.so".}
## * @}
