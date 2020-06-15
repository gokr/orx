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
##  @file orxStructure.h
##  @date 08/12/2003
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxStructure
##
##  Structure module
##  Allows to create and handle structures.
##  Structures can be referenced by other structures.
##
##  @{
##

import
  orxInclude, core/orxClock, memory/orxMemory, utils/orxLinkList, utils/orxTree

## * Structure pointer get helpers
##

template orxSTRUCTURE_GET_POINTER*(STRUCTURE, TYPE, ID: untyped): untyped =
  (cast[ptr TYPE](orxStructure_GetPointer(STRUCTURE, ID)))

template orxSTRUCTURE*(STRUCTURE: untyped): untyped =
  (if (((STRUCTURE) != orxNULL) and
      ((((cast[ptr orxSTRUCTURE](STRUCTURE)).u64GUID and
      orxSTRUCTURE_GUID_MASK_STRUCTURE_ID) shr
      orxSTRUCTURE_GUID_SHIFT_STRUCTURE_ID) < orxSTRUCTURE_ID_NUMBER)): cast[ptr orxSTRUCTURE]((
      STRUCTURE)) else: cast[ptr orxSTRUCTURE](orxNULL))

template orxANIM*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxANIM, orxSTRUCTURE_ID_ANIM)

template orxANIMPOINTER*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxANIMPOINTER, orxSTRUCTURE_ID_ANIMPOINTER)

template orxANIMSET*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxANIMSET, orxSTRUCTURE_ID_ANIMSET)

template orxBODY*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxBODY, orxSTRUCTURE_ID_BODY)

template orxCAMERA*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxCAMERA, orxSTRUCTURE_ID_CAMERA)

template orxCLOCK*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxCLOCK, orxSTRUCTURE_ID_CLOCK)

template orxFONT*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxFONT, orxSTRUCTURE_ID_FONT)

template orxFRAME*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxFRAME, orxSTRUCTURE_ID_FRAME)

template orxFX*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxFX, orxSTRUCTURE_ID_FX)

template orxFXPOINTER*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxFXPOINTER, orxSTRUCTURE_ID_FXPOINTER)

template orxGRAPHIC*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxGRAPHIC, orxSTRUCTURE_ID_GRAPHIC)

template orxOBJECT*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxOBJECT, orxSTRUCTURE_ID_OBJECT)

template orxSOUND*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxSOUND, orxSTRUCTURE_ID_SOUND)

template orxSOUNDPOINTER*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxSOUNDPOINTER,
                           orxSTRUCTURE_ID_SOUNDPOINTER)

template orxSHADER*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxSHADER, orxSTRUCTURE_ID_SHADER)

template orxSHADERPOINTER*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxSHADERPOINTER,
                           orxSTRUCTURE_ID_SHADERPOINTER)

template orxSPAWNER*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxSPAWNER, orxSTRUCTURE_ID_SPAWNER)

template orxTEXT*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxTEXT, orxSTRUCTURE_ID_TEXT)

template orxTEXTURE*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxTEXTURE, orxSTRUCTURE_ID_TEXTURE)

template orxTIMELINE*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxTIMELINE, orxSTRUCTURE_ID_TIMELINE)

template orxVIEWPORT*(STRUCTURE: untyped): untyped =
  orxSTRUCTURE_GET_POINTER(STRUCTURE, orxVIEWPORT, orxSTRUCTURE_ID_VIEWPORT)

## * Structure register macro
##

## * Structure assert
##

## * Structure magic number
##

const
  orxSTRUCTURE_GUID_MAGIC_TAG_DELETED* = 0x0000000000000000'i64

## * Structure GUID masks/shifts
##

const
  orxSTRUCTURE_GUID_MASK_STRUCTURE_ID* = 0x0000000000000000'i64
  orxSTRUCTURE_GUID_SHIFT_STRUCTURE_ID* = 0
  orxSTRUCTURE_GUID_MASK_ITEM_ID* = 0x0000000000000000'i64
  orxSTRUCTURE_GUID_SHIFT_ITEM_ID* = 32
  orxSTRUCTURE_GUID_MASK_REF_COUNT* = 0x0000000000000000'i64
  orxSTRUCTURE_GUID_SHIFT_REF_COUNT* = 48
  orxSTRUCTURE_GUID_MASK_INSTANCE_ID* = 0x0000000000000000'i64
  orxSTRUCTURE_GUID_SHIFT_INSTANCE_ID* = 5

## * Structure IDs
##

type                          ##  *** Following structures can be linked to objects ***
  orxSTRUCTURE_ID* {.size: sizeof(cint).} = enum
    orxSTRUCTURE_ID_ANIMPOINTER = 0, orxSTRUCTURE_ID_BODY, orxSTRUCTURE_ID_CLOCK,
    orxSTRUCTURE_ID_FRAME, orxSTRUCTURE_ID_FXPOINTER, orxSTRUCTURE_ID_GRAPHIC,
    orxSTRUCTURE_ID_SHADERPOINTER, orxSTRUCTURE_ID_SOUNDPOINTER,
    orxSTRUCTURE_ID_SPAWNER, orxSTRUCTURE_ID_TIMELINE, orxSTRUCTURE_ID_LINKABLE_NUMBER, ##  *** Below this point, structures can not be linked to objects ***
    orxSTRUCTURE_ID_ANIMSET, orxSTRUCTURE_ID_CAMERA, orxSTRUCTURE_ID_FONT,
    orxSTRUCTURE_ID_FX, orxSTRUCTURE_ID_OBJECT, orxSTRUCTURE_ID_SHADER,
    orxSTRUCTURE_ID_SOUND, orxSTRUCTURE_ID_TEXT, orxSTRUCTURE_ID_TEXTURE,
    orxSTRUCTURE_ID_VIEWPORT, orxSTRUCTURE_ID_NUMBER,
    orxSTRUCTURE_ID_NONE = orxENUM_NONE

const
  orxSTRUCTURE_ID_ANIM = orxSTRUCTURE_ID_LINKABLE_NUMBER

## * Structure storage types
##

type
  orxSTRUCTURE_STORAGE_TYPE* {.size: sizeof(cint).} = enum
    orxSTRUCTURE_STORAGE_TYPE_LINKLIST = 0, orxSTRUCTURE_STORAGE_TYPE_TREE,
    orxSTRUCTURE_STORAGE_TYPE_NUMBER,
    orxSTRUCTURE_STORAGE_TYPE_NONE = orxENUM_NONE


## * Public structure (Must be first derived structure member!)
##

type
  INNER_C_UNION_orxStructure_206* {.bycopy.} = object {.union.}
    stLinkListNode*: orxLINKLIST_NODE ## *< Linklist node : 28/40
    stTreeNode*: orxTREE_NODE  ## *< Tree node : 36/56

  orxSTRUCTURE* {.bycopy.} = object
    u64GUID*: orxU64           ## *< Structure GUID : 8
    u64OwnerGUID*: orxU64      ## *< Owner's GUID : 16
    stStorage*: INNER_C_UNION_orxStructure_206 ## *< Storage node union : 36/56
    u32Flags*: orxU32          ## *< Flags : 40/64


## * Structure update callback function type
##

type
  orxSTRUCTURE_UPDATE_FUNCTION* = proc (pstStructure: ptr orxSTRUCTURE;
                                     pstCaller: ptr orxSTRUCTURE;
                                     pstClockInfo: ptr orxCLOCK_INFO): orxSTATUS {.
      cdecl.}

## * Gets structure pointer / debug mode
##  @param[in]   _pStructure    Concerned structure
##  @param[in]   _eStructureID   ID to test the structure against
##  @return      Valid orxSTRUCTURE, orxNULL otherwise
##

proc orxStructure_GetPointer*(pStructure: pointer; eStructureID: orxSTRUCTURE_ID): ptr orxSTRUCTURE {.
    cdecl.} =
  discard

## * Gets structure ID string
##  @param[in]   _eID                       Concerned ID
##  @return      Corresponding literal string
##

proc orxStructure_GetIDString*(eID: orxSTRUCTURE_ID): ptr orxCHAR {.cdecl.} =
  discard

## * Structure module setup
##

proc orxStructure_Setup*() {.cdecl, importcpp: "orxStructure_Setup(@)",
                           dynlib: "liborx.so".}
## * Initializess the structure module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxStructure_Init*(): orxSTATUS {.cdecl, importcpp: "orxStructure_Init(@)",
                                    dynlib: "liborx.so".}
## * Exits from the structure module
##

proc orxStructure_Exit*() {.cdecl, importcpp: "orxStructure_Exit(@)",
                          dynlib: "liborx.so".}
## * Registers a given ID
##  @param[in]   _eStructureID   Concerned structure ID
##  @param[in]   _eStorageType   Storage type to use for this structure type
##  @param[in]   _eMemoryType    Memory type to store this structure type
##  @param[in]   _u32Size        Structure size
##  @param[in]   _u32BankSize    Bank (segment) size
##  @param[in]   _pfnUpdate      Structure update function
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxStructure_Register*(eStructureID: orxSTRUCTURE_ID;
                           eStorageType: orxSTRUCTURE_STORAGE_TYPE;
                           eMemoryType: orxMEMORY_TYPE; u32Size: orxU32;
                           u32BankSize: orxU32;
                           pfnUpdate: orxSTRUCTURE_UPDATE_FUNCTION): orxSTATUS {.
    cdecl, importcpp: "orxStructure_Register(@)", dynlib: "liborx.so".}
## * Unregisters a given ID
##  @param[in]   _eStructureID   Concerned structure ID
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxStructure_Unregister*(eStructureID: orxSTRUCTURE_ID): orxSTATUS {.cdecl,
    importcpp: "orxStructure_Unregister(@)", dynlib: "liborx.so".}
## * Creates a clean structure for given type
##  @param[in]   _eStructureID   Concerned structure ID
##  @return      orxSTRUCTURE / orxNULL
##

proc orxStructure_Create*(eStructureID: orxSTRUCTURE_ID): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_Create(@)", dynlib: "liborx.so".}
## * Deletes a structure (needs to be cleaned beforehand)
##  @param[in]   _pStructure    Concerned structure
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxStructure_Delete*(pStructure: pointer): orxSTATUS {.cdecl,
    importcpp: "orxStructure_Delete(@)", dynlib: "liborx.so".}
## * Gets structure storage type
##  @param[in]   _eStructureID   Concerned structure ID
##  @return      orxSTRUCTURE_STORAGE_TYPE
##

proc orxStructure_GetStorageType*(eStructureID: orxSTRUCTURE_ID): orxSTRUCTURE_STORAGE_TYPE {.
    cdecl, importcpp: "orxStructure_GetStorageType(@)", dynlib: "liborx.so".}
## * Gets given type structure count
##  @param[in]   _eStructureID   Concerned structure ID
##  @return      orxU32 / orxU32_UNDEFINED
##

proc orxStructure_GetCount*(eStructureID: orxSTRUCTURE_ID): orxU32 {.cdecl,
    importcpp: "orxStructure_GetCount(@)", dynlib: "liborx.so".}
## * Updates structure if update function was registered for the structure type
##  @param[in]   _pStructure     Concerned structure
##  @param[in]   _phCaller       Caller structure
##  @param[in]   _pstClockInfo   Update associated clock info
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxStructure_Update*(pStructure: pointer; phCaller: pointer;
                         pstClockInfo: ptr orxCLOCK_INFO): orxSTATUS {.cdecl,
    importcpp: "orxStructure_Update(@)", dynlib: "liborx.so".}
## * *** Structure storage accessors ***
## * Gets structure given its GUID
##  @param[in]   _u64GUID        Structure's GUID
##  @return      orxSTRUCTURE / orxNULL if not found/alive
##

proc orxStructure_Get*(u64GUID: orxU64): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_Get(@)", dynlib: "liborx.so".}
## * Gets structure's owner
##  @param[in]   _pStructure    Concerned structure
##  @return      orxSTRUCTURE / orxNULL if not found/alive
##

proc orxStructure_GetOwner*(pStructure: pointer): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_GetOwner(@)", dynlib: "liborx.so".}
## * Sets structure owner
##  @param[in]   _pStructure    Concerned structure
##  @param[in]   _pOwner        Structure to set as owner
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxStructure_SetOwner*(pStructure: pointer; pOwner: pointer): orxSTATUS {.cdecl,
    importcpp: "orxStructure_SetOwner(@)", dynlib: "liborx.so".}
## * Gets first stored structure (first list cell or tree root depending on storage type)
##  @param[in]   _eStructureID   Concerned structure ID
##  @return      orxSTRUCTURE
##

proc orxStructure_GetFirst*(eStructureID: orxSTRUCTURE_ID): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_GetFirst(@)", dynlib: "liborx.so".}
## * Gets last stored structure (last list cell or tree root depending on storage type)
##  @param[in]   _eStructureID   Concerned structure ID
##  @return      orxSTRUCTURE
##

proc orxStructure_GetLast*(eStructureID: orxSTRUCTURE_ID): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_GetLast(@)", dynlib: "liborx.so".}
## * Gets structure tree parent
##  @param[in]   _pStructure    Concerned structure
##  @return      orxSTRUCTURE
##

proc orxStructure_GetParent*(pStructure: pointer): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_GetParent(@)", dynlib: "liborx.so".}
## * Gets structure tree child
##  @param[in]   _pStructure    Concerned structure
##  @return      orxSTRUCTURE
##

proc orxStructure_GetChild*(pStructure: pointer): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_GetChild(@)", dynlib: "liborx.so".}
## * Gets structure tree sibling
##  @param[in]   _pStructure    Concerned structure
##  @return      orxSTRUCTURE
##

proc orxStructure_GetSibling*(pStructure: pointer): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_GetSibling(@)", dynlib: "liborx.so".}
## * Gets structure list previous
##  @param[in]   _pStructure    Concerned structure
##  @return      orxSTRUCTURE
##

proc orxStructure_GetPrevious*(pStructure: pointer): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_GetPrevious(@)", dynlib: "liborx.so".}
## * Gets structure list next
##  @param[in]   _pStructure    Concerned structure
##  @return      orxSTRUCTURE
##

proc orxStructure_GetNext*(pStructure: pointer): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxStructure_GetNext(@)", dynlib: "liborx.so".}
## * Sets structure tree parent
##  @param[in]   _pStructure    Concerned structure
##  @param[in]   _phParent       Structure to set as parent
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxStructure_SetParent*(pStructure: pointer; phParent: pointer): orxSTATUS {.
    cdecl, importcpp: "orxStructure_SetParent(@)", dynlib: "liborx.so".}
## * Logs all user-generated active structures
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxStructure_LogAll*(): orxSTATUS {.cdecl, importcpp: "orxStructure_LogAll(@)",
                                      dynlib: "liborx.so".}
## * *** Inlined structure accessors ***
## * Increases structure reference count
##  @param[in]   _pStructure    Concerned structure
##

proc orxStructure_IncreaseCount*(pStructure: pointer) {.cdecl.} =
  discard

## * Decreases structure reference count
##  @param[in]   _pStructure    Concerned structure
##

proc orxStructure_DecreaseCount*(pStructure: pointer) {.cdecl.} =
  discard

## * Gets structure reference count
##  @param[in]   _pStructure    Concerned structure
##  @return      orxU32
##

proc orxStructure_GetRefCount*(pStructure: pointer): orxU32 {.cdecl.} =
  discard

## * Gets structure GUID
##  @param[in]   _pStructure    Concerned structure
##  @return      orxU64
##

proc orxStructure_GetGUID*(pStructure: pointer): orxU64 {.cdecl.} =
  discard

## * Gets structure ID
##  @param[in]   _pStructure    Concerned structure
##  @return      orxSTRUCTURE_ID
##

proc orxStructure_GetID*(pStructure: pointer): orxSTRUCTURE_ID {.cdecl.} =
  discard

## * Tests flags against structure ones
##  @param[in]   _pStructure    Concerned structure
##  @param[in]   _u32Flags      Flags to test
##  @return      orxTRUE / orxFALSE
##

proc orxStructure_TestFlags*(pStructure: pointer; u32Flags: orxU32): orxBOOL {.cdecl.} =
  discard

## * Tests all flags against structure ones
##  @param[in]   _pStructure    Concerned structure
##  @param[in]   _u32Flags      Flags to test
##  @return      orxTRUE / orxFALSE
##

proc orxStructure_TestAllFlags*(pStructure: pointer; u32Flags: orxU32): orxBOOL {.
    cdecl.} =
  discard

## * Gets structure flags
##  @param[in]   _pStructure    Concerned structure
##  @param[in]   _u32Mask       Mask to use for getting flags
##  @return      orxU32
##

proc orxStructure_GetFlags*(pStructure: pointer; u32Mask: orxU32): orxU32 {.cdecl.} =
  discard

## * Sets structure flags
##  @param[in]   _pStructure    Concerned structure
##  @param[in]   _u32AddFlags    Flags to add
##  @param[in]   _u32RemoveFlags Flags to remove
##

proc orxStructure_SetFlags*(pStructure: pointer; u32AddFlags: orxU32;
                           u32RemoveFlags: orxU32) {.cdecl.} =
  discard

## * @}
