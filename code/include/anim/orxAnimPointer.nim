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
##  @file orxAnimPointer.h
##  @date 03/03/2004
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxAnimPointer
##
##  Animation (Pointer) Module.
##  Allows to creates and handle Animation Set Pointers.
##  It consists of a structure containing pointers and counters referenced to an Animation Set.
##  It also contains functions for handling and accessing animations of the referenced Animation Set.
##  Animation Pointers are structures.
##  They thus can be referenced by Graphics.
##
##  @{
##

import
  orxInclude, anim/orxAnimSet

import
  base/orxType, obj/orxStructure

## * Internal AnimPointer structure
##

type orxANIMPOINTER* = object
## * AnimPointer module setup
##

proc orxAnimPointer_Setup*() {.cdecl, importc: "orxAnimPointer_Setup",
                             dynlib: "liborx.so".}
## * Inits the AnimPointer module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_Init*(): orxSTATUS {.cdecl, importc: "orxAnimPointer_Init",
                                      dynlib: "liborx.so".}
## * Exits from the AnimPointer module
##

proc orxAnimPointer_Exit*() {.cdecl, importc: "orxAnimPointer_Exit",
                            dynlib: "liborx.so".}
## * Creates an empty AnimPointer
##  @param[in]   _pstAnimSet                   AnimSet reference
##  @return      orxANIMPOINTER / nil
##

proc orxAnimPointer_Create*(pstAnimSet: ptr orxANIMSET): ptr orxANIMPOINTER {.cdecl,
    importc: "orxAnimPointer_Create", dynlib: "liborx.so".}
## * Creates an animation pointer from config
##  @param[in]   _zConfigID                    Config ID
##  @return      orxANIMPOINTER / nil
##

proc orxAnimPointer_CreateFromConfig*(zConfigID: ptr orxCHAR): ptr orxANIMPOINTER {.
    cdecl, importc: "orxAnimPointer_CreateFromConfig", dynlib: "liborx.so".}
## * Deletes an AnimPointer
##  @param[in]   _pstAnimPointer               AnimPointer to delete
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_Delete*(pstAnimPointer: ptr orxANIMPOINTER): orxSTATUS {.cdecl,
    importc: "orxAnimPointer_Delete", dynlib: "liborx.so".}
## * Gets the referenced AnimSet
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @return      Referenced orxANIMSET
##

proc orxAnimPointer_GetAnimSet*(pstAnimPointer: ptr orxANIMPOINTER): ptr orxANIMSET {.
    cdecl, importc: "orxAnimPointer_GetAnimSet", dynlib: "liborx.so".}
## * AnimPointer current Animation get accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @return      Current Animation ID
##

proc orxAnimPointer_GetCurrentAnim*(pstAnimPointer: ptr orxANIMPOINTER): orxU32 {.
    cdecl, importc: "orxAnimPointer_GetCurrentAnim", dynlib: "liborx.so".}
## * AnimPointer target Animation get accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @return      Target Animation ID
##

proc orxAnimPointer_GetTargetAnim*(pstAnimPointer: ptr orxANIMPOINTER): orxU32 {.
    cdecl, importc: "orxAnimPointer_GetTargetAnim", dynlib: "liborx.so".}
## * AnimPointer current Animation name get accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @return      Current Animation name / orxSTRING_EMPTY
##

proc orxAnimPointer_GetCurrentAnimName*(pstAnimPointer: ptr orxANIMPOINTER): ptr orxCHAR {.
    cdecl, importc: "orxAnimPointer_GetCurrentAnimName", dynlib: "liborx.so".}
## * AnimPointer target Animation ID get accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @return      Target Animation name / orxSTRING_EMPTY
##

proc orxAnimPointer_GetTargetAnimName*(pstAnimPointer: ptr orxANIMPOINTER): ptr orxCHAR {.
    cdecl, importc: "orxAnimPointer_GetTargetAnimName", dynlib: "liborx.so".}
## * AnimPointer current anim data get accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @return      Current anim data / nil
##

proc orxAnimPointer_GetCurrentAnimData*(pstAnimPointer: ptr orxANIMPOINTER): ptr orxSTRUCTURE {.
    cdecl, importc: "orxAnimPointer_GetCurrentAnimData", dynlib: "liborx.so".}
## * AnimPointer time get accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @return      Current time
##

proc orxAnimPointer_GetTime*(pstAnimPointer: ptr orxANIMPOINTER): orxFLOAT {.cdecl,
    importc: "orxAnimPointer_GetTime", dynlib: "liborx.so".}
## * AnimPointer frequency get accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @return      AnimPointer frequency
##

proc orxAnimPointer_GetFrequency*(pstAnimPointer: ptr orxANIMPOINTER): orxFLOAT {.
    cdecl, importc: "orxAnimPointer_GetFrequency", dynlib: "liborx.so".}
## * AnimPointer current Animation set accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @param[in]   _u32AnimID                    Animation ID to set
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_SetCurrentAnim*(pstAnimPointer: ptr orxANIMPOINTER;
                                   u32AnimID: orxU32): orxSTATUS {.cdecl,
    importc: "orxAnimPointer_SetCurrentAnim", dynlib: "liborx.so".}
## * AnimPointer target Animation set accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @param[in]   _u32AnimID                    Animation ID to set / orxU32_UNDEFINED
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_SetTargetAnim*(pstAnimPointer: ptr orxANIMPOINTER;
                                  u32AnimID: orxU32): orxSTATUS {.cdecl,
    importc: "orxAnimPointer_SetTargetAnim", dynlib: "liborx.so".}
## * AnimPointer current Animation set accessor using name
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @param[in]   _zAnimName                    Animation name (config's name) to set
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_SetCurrentAnimFromName*(pstAnimPointer: ptr orxANIMPOINTER;
    zAnimName: ptr orxCHAR): orxSTATUS {.cdecl, importc: "orxAnimPointer_SetCurrentAnimFromName",
                                     dynlib: "liborx.so".}
## * AnimPointer target Animation set accessor using name
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @param[in]   _zAnimName                    Animation name (config's name) to set / nil
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_SetTargetAnimFromName*(pstAnimPointer: ptr orxANIMPOINTER;
    zAnimName: ptr orxCHAR): orxSTATUS {.cdecl, importc: "orxAnimPointer_SetTargetAnimFromName",
                                     dynlib: "liborx.so".}
## * AnimPointer current time set accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @param[in]   _fTime                        Time to set
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_SetTime*(pstAnimPointer: ptr orxANIMPOINTER; fTime: orxFLOAT): orxSTATUS {.
    cdecl, importc: "orxAnimPointer_SetTime", dynlib: "liborx.so".}
## * AnimPointer frequency set accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @param[in]   _fFrequency                   Frequency to set
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_SetFrequency*(pstAnimPointer: ptr orxANIMPOINTER;
                                 fFrequency: orxFLOAT): orxSTATUS {.cdecl,
    importc: "orxAnimPointer_SetFrequency", dynlib: "liborx.so".}
## * AnimPointer pause accessor
##  @param[in]   _pstAnimPointer               Concerned AnimPointer
##  @param[in]   _bPause                       Pause / Unpause
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxAnimPointer_Pause*(pstAnimPointer: ptr orxANIMPOINTER; bPause: orxBOOL): orxSTATUS {.
    cdecl, importc: "orxAnimPointer_Pause", dynlib: "liborx.so".}
## * @}
