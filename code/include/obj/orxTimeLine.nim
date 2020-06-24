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
##  @file orxTimeLine.h
##  @date 22/04/2012
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxTimeLine
##
##  TimeLine module
##  Allows to creates time lines: sequences of text events
##
##  @{
##

import
  orxInclude, obj/orxStructure

import
  base/orxType

## * Internal TimeLine structure
##

type orxTIMELINE* = object
## * Event enum
##

type
  orxTIMELINE_EVENT* {.size: sizeof(cint).} = enum
    orxTIMELINE_EVENT_TRACK_START = 0, ## *< Event sent when a track starts
    orxTIMELINE_EVENT_TRACK_STOP, ## *< Event sent when a track stops
    orxTIMELINE_EVENT_TRACK_ADD, ## *< Event sent when a track is added
    orxTIMELINE_EVENT_TRACK_REMOVE, ## *< Event sent when a track is removed
    orxTIMELINE_EVENT_LOOP,   ## *< Event sent when a track is looping
    orxTIMELINE_EVENT_TRIGGER, ## *< Event sent when an event is triggered
    orxTIMELINE_EVENT_NUMBER, orxTIMELINE_EVENT_NONE = orxENUM_NONE


## * TimeLine event payload
##

type
  orxTIMELINE_EVENT_PAYLOAD* {.bycopy.} = object
    pstTimeLine*: ptr orxTIMELINE ## *< TimeLine reference : 4
    zTrackName*: ptr orxCHAR    ## *< Track name : 8
    zEvent*: ptr orxCHAR        ## *< Event text : 12
    fTimeStamp*: orxFLOAT      ## *< Event time : 16


## * TimeLine module setup
##

proc orxTimeLine_Setup*() {.cdecl, importc: "orxTimeLine_Setup", dynlib: "liborx.so".}
## * Inits the TimeLine module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTimeLine_Init*(): orxSTATUS {.cdecl, importc: "orxTimeLine_Init",
                                   dynlib: "liborx.so".}
## * Exits from the TimeLine module
##

proc orxTimeLine_Exit*() {.cdecl, importc: "orxTimeLine_Exit", dynlib: "liborx.so".}
## * Creates an empty TimeLine
##  @return orxTIMELINE / nil
##

proc orxTimeLine_Create*(): ptr orxTIMELINE {.cdecl, importc: "orxTimeLine_Create",
    dynlib: "liborx.so".}
## * Deletes a TimeLine
##  @param[in] _pstTimeLine            Concerned TimeLine
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTimeLine_Delete*(pstTimeLine: ptr orxTIMELINE): orxSTATUS {.cdecl,
    importc: "orxTimeLine_Delete", dynlib: "liborx.so".}
## * Clears cache (if any TimeLine track is still in active use, it'll remain in memory until not referenced anymore)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTimeLine_ClearCache*(): orxSTATUS {.cdecl,
    importc: "orxTimeLine_ClearCache", dynlib: "liborx.so".}
## * Enables/disables a TimeLine
##  @param[in]   _pstTimeLine          Concerned TimeLine
##  @param[in]   _bEnable              Enable / disable
##

proc orxTimeLine_Enable*(pstTimeLine: ptr orxTIMELINE; bEnable: orxBOOL) {.cdecl,
    importc: "orxTimeLine_Enable", dynlib: "liborx.so".}
## * Is TimeLine enabled?
##  @param[in]   _pstTimeLine          Concerned TimeLine
##  @return      orxTRUE if enabled, orxFALSE otherwise
##

proc orxTimeLine_IsEnabled*(pstTimeLine: ptr orxTIMELINE): orxBOOL {.cdecl,
    importc: "orxTimeLine_IsEnabled", dynlib: "liborx.so".}
## * Adds a track to a TimeLine from config
##  @param[in]   _pstTimeLine          Concerned TimeLine
##  @param[in]   _zTrackID             Config ID
##  return       orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTimeLine_AddTrackFromConfig*(pstTimeLine: ptr orxTIMELINE;
                                    zTrackID: ptr orxCHAR): orxSTATUS {.cdecl,
    importc: "orxTimeLine_AddTrackFromConfig", dynlib: "liborx.so".}
## * Removes a track using its config ID
##  @param[in]   _pstTimeLine          Concerned TimeLine
##  @param[in]   _zTrackID             Config ID of the track to remove
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTimeLine_RemoveTrackFromConfig*(pstTimeLine: ptr orxTIMELINE;
                                       zTrackID: ptr orxCHAR): orxSTATUS {.cdecl,
    importc: "orxTimeLine_RemoveTrackFromConfig", dynlib: "liborx.so".}
## * Gets how many tracks are currently in use
##  @param[in]   _pstTimeLine          Concerned TimeLine
##  @return      orxU32
##

proc orxTimeLine_GetCount*(pstTimeLine: ptr orxTIMELINE): orxU32 {.cdecl,
    importc: "orxTimeLine_GetCount", dynlib: "liborx.so".}
## * Gets a track duration using its config ID
##  @param[in]   _zTrackID             Config ID of the concerned track
##  @return      Duration if found, -orxFLOAT_1 otherwise
##

proc orxTimeLine_GetTrackDuration*(zTrackID: ptr orxCHAR): orxFLOAT {.cdecl,
    importc: "orxTimeLine_GetTrackDuration", dynlib: "liborx.so".}
## * @}
