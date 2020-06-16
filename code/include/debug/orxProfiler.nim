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
##  @file orxProfiler.h
##  @date 29/04/2011
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxProfiler
##
##  Profiler Module
##  Allows to profile code execution
##
##  @{
##

import
  orxInclude, core/orxThread

import
  base/orxType

##  *** Uncomment the line below to enable orx profiling in non debug builds ***
## #define __orxPROFILER__
## * Profiler macros
##

when defined(PROFILER):
  template orxPROFILER_PUSH_MARKER*(NAME: untyped): void =
    while true:
      var s32ProfilerID: orxS32
      if orxProfiler_IsMarkerIDValid(s32ProfilerID) == orxFALSE:
        s32ProfilerID = orxProfiler_GetIDFromName(NAME)
      orxProfiler_PushMarker(s32ProfilerID)
      if not orxFALSE:
        break

  template orxPROFILER_POP_MARKER*(): void =
    while true:
      orxProfiler_PopMarker()
      if not orxFALSE:
        break

  const
    orxPROFILER_KU32_HISTORY_LENGTH* = (3 * 60)
else:
  template orxPROFILER_PUSH_MARKER*(NAME: untyped): void =
    nil

  template orxPROFILER_POP_MARKER*(): void =
    nil

  const
    orxPROFILER_KU32_HISTORY_LENGTH* = 2
## * Defines
##

const
  orxPROFILER_KS32_MARKER_ID_NONE* = -1

## * Setups Profiler module

proc orxProfiler_Setup*() {.cdecl, importc: "orxProfiler_Setup", dynlib: "liborx.so".}
## * Inits the Profiler module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxProfiler_Init*(): orxSTATUS {.cdecl, importc: "orxProfiler_Init",
                                   dynlib: "liborx.so".}
## * Exits from the Profiler module

proc orxProfiler_Exit*() {.cdecl, importc: "orxProfiler_Exit", dynlib: "liborx.so".}
## * Gets a marker ID given a name
##  @param[in] _zName            Name of the marker
##  @return Marker's ID / orxPROFILER_KS32_MARKER_ID_NONE
##

proc orxProfiler_GetIDFromName*(zName: ptr orxCHAR): orxS32 {.cdecl,
    importc: "orxProfiler_GetIDFromName", dynlib: "liborx.so".}
## * Is the given marker valid? (Useful when storing markers in static variables and still allow normal hot restart)
##  @param[in] _s32MarkerID      ID of the marker to test
##  @return orxTRUE / orxFALSE
##

proc orxProfiler_IsMarkerIDValid*(s32MarkerID: orxS32): orxBOOL {.cdecl,
    importc: "orxProfiler_IsMarkerIDValid", dynlib: "liborx.so".}
## * Pushes a marker (on a stack) and starts a timer for it
##  @param[in] _s32MarkerID      ID of the marker to push
##

proc orxProfiler_PushMarker*(s32MarkerID: orxS32) {.cdecl,
    importc: "orxProfiler_PushMarker", dynlib: "liborx.so".}
## * Pops a marker (from the stack) and updates its cumulated time (using the last marker push time)
##

proc orxProfiler_PopMarker*() {.cdecl, importc: "orxProfiler_PopMarker",
                              dynlib: "liborx.so".}
## * Enables marker push/pop operations
##  @param[in] _bEnable          Enable
##

proc orxProfiler_EnableMarkerOperations*(bEnable: orxBOOL) {.cdecl,
    importc: "orxProfiler_EnableMarkerOperations", dynlib: "liborx.so".}
## * Are marker push/pop operations enabled?
##  @return orxTRUE / orxFALSE
##

proc orxProfiler_AreMarkerOperationsEnabled*(): orxBOOL {.cdecl,
    importc: "orxProfiler_AreMarkerOperationsEnabled", dynlib: "liborx.so".}
## * Pauses/unpauses the profiler
##  @param[in] _bPause           Pause
##

proc orxProfiler_Pause*(bPause: orxBOOL) {.cdecl, importc: "orxProfiler_Pause",
                                        dynlib: "liborx.so".}
## * Is profiler paused?
##  @return orxTRUE / orxFALSE
##

proc orxProfiler_IsPaused*(): orxBOOL {.cdecl, importc: "orxProfiler_IsPaused",
                                     dynlib: "liborx.so".}
## * Resets all markers (usually called at the end of the frame)
##

proc orxProfiler_ResetAllMarkers*() {.cdecl,
                                    importc: "orxProfiler_ResetAllMarkers",
                                    dynlib: "liborx.so".}
## * Resets all maxima (usually called at a regular interval)
##

proc orxProfiler_ResetAllMaxima*() {.cdecl, importc: "orxProfiler_ResetAllMaxima",
                                   dynlib: "liborx.so".}
## * Gets the time elapsed since last reset
##  @return Time elapsed since the last reset, in seconds
##

proc orxProfiler_GetResetTime*(): orxDOUBLE {.cdecl,
    importc: "orxProfiler_GetResetTime", dynlib: "liborx.so".}
## * Gets the maximum reset time
##  @return Max reset time, in seconds
##

proc orxProfiler_GetMaxResetTime*(): orxDOUBLE {.cdecl,
    importc: "orxProfiler_GetMaxResetTime", dynlib: "liborx.so".}
## * Gets the number of registered markers used on the queried thread
##  @return Number of registered markers
##

proc orxProfiler_GetMarkerCount*(): orxS32 {.cdecl,
    importc: "orxProfiler_GetMarkerCount", dynlib: "liborx.so".}
## * Gets the next registered marker ID
##  @param[in] _s32MarkerID      ID of the current marker, orxPROFILER_KS32_MARKER_ID_NONE to get the first one
##  @return Next registered marker's ID / orxPROFILER_KS32_MARKER_ID_NONE if the current marker was the last one
##

proc orxProfiler_GetNextMarkerID*(s32MarkerID: orxS32): orxS32 {.cdecl,
    importc: "orxProfiler_GetNextMarkerID", dynlib: "liborx.so".}
## * Gets the ID of the next marker, sorted by their push time
##  @param[in] _s32MarkerID      ID of the current pushed marker, orxPROFILER_KS32_MARKER_ID_NONE to get the first one
##  @return Next registered marker's ID / orxPROFILER_KS32_MARKER_ID_NONE if the current marker was the last one
##

proc orxProfiler_GetNextSortedMarkerID*(s32MarkerID: orxS32): orxS32 {.cdecl,
    importc: "orxProfiler_GetNextSortedMarkerID", dynlib: "liborx.so".}
## * Selects the query frame for all GetMarker* functions below, in number of frame elapsed from the last one
##  @param[in] _u32QueryFrame    Query frame, in number of frame elapsed since the last one (ie. 0 -> last frame, 1 -> frame before last, ...)
##  @param[in] _u32ThreadID      Concerned thread ID, if no data is found for this thread, orxSTATUS_FAILURE is returned
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxProfiler_SelectQueryFrame*(u32QueryFrame: orxU32; u32ThreadID: orxU32): orxSTATUS {.
    cdecl, importc: "orxProfiler_SelectQueryFrame", dynlib: "liborx.so".}
## * Gets the marker's cumulated time
##  @param[in] _s32MarkerID      Concerned marker ID
##  @return Marker's cumulated time
##

proc orxProfiler_GetMarkerTime*(s32MarkerID: orxS32): orxDOUBLE {.cdecl,
    importc: "orxProfiler_GetMarkerTime", dynlib: "liborx.so".}
## * Gets the marker's maximum cumulated time
##  @param[in] _s32MarkerID      Concerned marker ID
##  @return Marker's max cumulated time
##

proc orxProfiler_GetMarkerMaxTime*(s32MarkerID: orxS32): orxDOUBLE {.cdecl,
    importc: "orxProfiler_GetMarkerMaxTime", dynlib: "liborx.so".}
## * Gets the marker's name
##  @param[in] _s32MarkerID      Concerned marker ID
##  @return Marker's name
##

proc orxProfiler_GetMarkerName*(s32MarkerID: orxS32): ptr orxCHAR {.cdecl,
    importc: "orxProfiler_GetMarkerName", dynlib: "liborx.so".}
## * Gets the marker's push count
##  @param[in] _s32MarkerID      Concerned marker ID
##  @return Number of time the marker has been pushed since last reset
##

proc orxProfiler_GetMarkerPushCount*(s32MarkerID: orxS32): orxU32 {.cdecl,
    importc: "orxProfiler_GetMarkerPushCount", dynlib: "liborx.so".}
## * Has the marker been pushed by a unique parent?
##  @param[in] _s32MarkerID      Concerned marker ID
##  @return orxTRUE / orxFALSE
##

proc orxProfiler_IsUniqueMarker*(s32MarkerID: orxS32): orxBOOL {.cdecl,
    importc: "orxProfiler_IsUniqueMarker", dynlib: "liborx.so".}
## * Gets the uniquely pushed marker's start time
##  @param[in] _s32MarkerID      Concerned marker ID
##  @return Marker's start time / 0.0
##

proc orxProfiler_GetUniqueMarkerStartTime*(s32MarkerID: orxS32): orxDOUBLE {.cdecl,
    importc: "orxProfiler_GetUniqueMarkerStartTime", dynlib: "liborx.so".}
## * Gets the uniquely pushed marker's depth, 1 being the depth of the top level
##  @param[in] _s32MarkerID      Concerned marker ID
##  @return Marker's push depth / 0 if this marker hasn't been uniquely pushed
##

proc orxProfiler_GetUniqueMarkerDepth*(s32MarkerID: orxS32): orxU32 {.cdecl,
    importc: "orxProfiler_GetUniqueMarkerDepth", dynlib: "liborx.so".}
## * @}
