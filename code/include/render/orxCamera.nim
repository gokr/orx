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
##  @file orxCamera.h
##  @date 10/12/2003
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxCamera
##
##  Camera Module
##  Allows to creates and handle cameras
##  Camera are structures used to render graphic (2D/3D) objects
##  They thus can be referenced by other structures
##
##  @{
##

import
  orxInclude, obj/orxStructure, obj/orxFrame, math/orxAABox

import
  base/orxType, math/orxVector

## * Anim flags
##

const
  orxCAMERA_KU32_FLAG_NONE* = 0x00000000
  orxCAMERA_KU32_FLAG_2D* = 0x00000001
  orxCAMERA_KU32_MASK_USER_ALL* = 0x000000FF

## * Misc
##

const
  orxCAMERA_KU32_GROUP_ID_NUMBER* = 16

## * Internal camera structure
##

type orxCAMERA* = object
## * Camera module setup
##

proc orxCamera_Setup*() {.cdecl, importcpp: "orxCamera_Setup(@)", dynlib: "liborx.so".}
## * Inits the Camera module
##

proc orxCamera_Init*(): orxSTATUS {.cdecl, importcpp: "orxCamera_Init(@)",
                                 dynlib: "liborx.so".}
## * Exits from the Camera module
##

proc orxCamera_Exit*() {.cdecl, importcpp: "orxCamera_Exit(@)", dynlib: "liborx.so".}
## * Creates a camera
##  @param[in]   _u32Flags       Camera flags (2D / ...)
##  @return      Created orxCAMERA / orxNULL
##

proc orxCamera_Create*(u32Flags: orxU32): ptr orxCAMERA {.cdecl,
    importcpp: "orxCamera_Create(@)", dynlib: "liborx.so".}
## * Creates a camera from config
##  @param[in]   _zConfigID      Config ID
##  @ return orxCAMERA / orxNULL
##

proc orxCamera_CreateFromConfig*(zConfigID: ptr orxCHAR): ptr orxCAMERA {.cdecl,
    importcpp: "orxCamera_CreateFromConfig(@)", dynlib: "liborx.so".}
## * Deletes a camera
##  @param[in]   _pstCamera      Camera to delete
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxCamera_Delete*(pstCamera: ptr orxCAMERA): orxSTATUS {.cdecl,
    importcpp: "orxCamera_Delete(@)", dynlib: "liborx.so".}
## * Adds a group ID to a camera
##  @param[in] _pstCamera        Concerned camera
##  @param[in] _stGroupID        ID of the group to add
##  @param[in] _bAddFirst        If true this group will be used *before* any already added ones, otherwise it'll be used *after* all of them
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxCamera_AddGroupID*(pstCamera: ptr orxCAMERA; stGroupID: orxSTRINGID;
                          bAddFirst: orxBOOL): orxSTATUS {.cdecl,
    importcpp: "orxCamera_AddGroupID(@)", dynlib: "liborx.so".}
## * Removes a group ID from a camera
##  @param[in] _pstCamera        Concerned camera
##  @param[in] _stGroupID        ID of the group to remove
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxCamera_RemoveGroupID*(pstCamera: ptr orxCAMERA; stGroupID: orxSTRINGID): orxSTATUS {.
    cdecl, importcpp: "orxCamera_RemoveGroupID(@)", dynlib: "liborx.so".}
## * Gets number of group IDs of camera
##  @param[in] _pstCamera        Concerned camera
##  @return Number of group IDs of this camera
##

proc orxCamera_GetGroupIDCount*(pstCamera: ptr orxCAMERA): orxU32 {.cdecl,
    importcpp: "orxCamera_GetGroupIDCount(@)", dynlib: "liborx.so".}
## * Gets the group ID of a camera at the given index
##  @param[in] _pstCamera        Concerned camera
##  @param[in] _u32Index         Index of group ID
##  @return Group ID if index is valid, orxSTRINGID_UNDEFINED otherwise
##

proc orxCamera_GetGroupID*(pstCamera: ptr orxCAMERA; u32Index: orxU32): orxSTRINGID {.
    cdecl, importcpp: "orxCamera_GetGroupID(@)", dynlib: "liborx.so".}
## * Sets camera frustum
##  @param[in]   _pstCamera      Concerned camera
##  @param[in]   _fWidth         Width of frustum
##  @param[in]   _fHeight        Height of frustum
##  @param[in]   _fNear          Near distance of frustum
##  @param[in]   _fFar           Far distance of frustum
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxCamera_SetFrustum*(pstCamera: ptr orxCAMERA; fWidth: orxFLOAT;
                          fHeight: orxFLOAT; fNear: orxFLOAT; fFar: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxCamera_SetFrustum(@)", dynlib: "liborx.so".}
## * Sets camera position
##  @param[in]   _pstCamera      Concerned camera
##  @param[in]   _pvPosition     Camera position
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxCamera_SetPosition*(pstCamera: ptr orxCAMERA; pvPosition: ptr orxVECTOR): orxSTATUS {.
    cdecl, importcpp: "orxCamera_SetPosition(@)", dynlib: "liborx.so".}
## * Sets camera rotation
##  @param[in]   _pstCamera      Concerned camera
##  @param[in]   _fRotation      Camera rotation (radians)
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxCamera_SetRotation*(pstCamera: ptr orxCAMERA; fRotation: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxCamera_SetRotation(@)", dynlib: "liborx.so".}
## * Sets camera zoom
##  @param[in]   _pstCamera      Concerned camera
##  @param[in]   _fZoom          Camera zoom
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxCamera_SetZoom*(pstCamera: ptr orxCAMERA; fZoom: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxCamera_SetZoom(@)", dynlib: "liborx.so".}
## * Gets camera frustum (3D box for 2D camera)
##  @param[in]   _pstCamera      Concerned camera
##  @param[out]  _pstFrustum    Frustum box
##  @return      Frustum orxAABOX
##

proc orxCamera_GetFrustum*(pstCamera: ptr orxCAMERA; pstFrustum: ptr orxAABOX): ptr orxAABOX {.
    cdecl, importcpp: "orxCamera_GetFrustum(@)", dynlib: "liborx.so".}
## * Get camera position
##  @param[in]   _pstCamera      Concerned camera
##  @param[out]  _pvPosition     Camera position
##  @return      orxVECTOR
##

proc orxCamera_GetPosition*(pstCamera: ptr orxCAMERA; pvPosition: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxCamera_GetPosition(@)", dynlib: "liborx.so".}
## * Get camera rotation
##  @param[in]   _pstCamera      Concerned camera
##  @return      Rotation value (radians)
##

proc orxCamera_GetRotation*(pstCamera: ptr orxCAMERA): orxFLOAT {.cdecl,
    importcpp: "orxCamera_GetRotation(@)", dynlib: "liborx.so".}
## * Get camera zoom
##  @param[in]   _pstCamera      Concerned camera
##  @return      Zoom value
##

proc orxCamera_GetZoom*(pstCamera: ptr orxCAMERA): orxFLOAT {.cdecl,
    importcpp: "orxCamera_GetZoom(@)", dynlib: "liborx.so".}
## * Gets camera config name
##  @param[in]   _pstCamera      Concerned camera
##  @return      orxSTRING / orxSTRING_EMPTY
##

proc orxCamera_GetName*(pstCamera: ptr orxCAMERA): ptr orxCHAR {.cdecl,
    importcpp: "orxCamera_GetName(@)", dynlib: "liborx.so".}
## * Gets camera given its name
##  @param[in]   _zName          Camera name
##  @return      orxCAMERA / orxNULL
##

proc orxCamera_Get*(zName: ptr orxCHAR): ptr orxCAMERA {.cdecl,
    importcpp: "orxCamera_Get(@)", dynlib: "liborx.so".}
## * Gets camera frame
##  @param[in]   _pstCamera      Concerned camera
##  @return      orxFRAME
##

proc orxCamera_GetFrame*(pstCamera: ptr orxCAMERA): ptr orxFRAME {.cdecl,
    importcpp: "orxCamera_GetFrame(@)", dynlib: "liborx.so".}
## * Sets camera parent
##  @param[in]   _pstCamera      Concerned camera
##  @param[in]   _pParent        Parent structure to set (object, spawner, camera or frame) / orxNULL
##  @return      orsSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxCamera_SetParent*(pstCamera: ptr orxCAMERA; pParent: pointer): orxSTATUS {.
    cdecl, importcpp: "orxCamera_SetParent(@)", dynlib: "liborx.so".}
## * Gets camera parent
##  @param[in]   _pstCamera      Concerned camera
##  @return      Parent (object, spawner, camera or frame) / orxNULL
##

proc orxCamera_GetParent*(pstCamera: ptr orxCAMERA): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxCamera_GetParent(@)", dynlib: "liborx.so".}
## * @}
