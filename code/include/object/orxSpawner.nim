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
##  @file orxSpawner.h
##  @date 06/09/2008
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxSpawner
##
##  Spawner module
##  Allows to spawn orxSPAWNERS
##  Spawners derived from structures
##
##  @{
##

import
  orxInclude, object/orxStructure, object/orxFrame

## * Spawner flags
##

const
  orxSPAWNER_KU32_FLAG_NONE* = 0x00000000
  orxSPAWNER_KU32_FLAG_AUTO_DELETE* = 0x00000001
  orxSPAWNER_KU32_FLAG_AUTO_RESET* = 0x00000002
  orxSPAWNER_KU32_FLAG_USE_ALPHA* = 0x00000004
  orxSPAWNER_KU32_FLAG_USE_COLOR* = 0x00000008
  orxSPAWNER_KU32_FLAG_USE_ROTATION* = 0x00000010
  orxSPAWNER_KU32_FLAG_USE_SCALE* = 0x00000020
  orxSPAWNER_KU32_FLAG_USE_RELATIVE_SPEED* = 0x00000040
  orxSPAWNER_KU32_FLAG_USE_SELF_AS_PARENT* = 0x00000080
  orxSPAWNER_KU32_FLAG_CLEAN_ON_DELETE* = 0x00000100
  orxSPAWNER_KU32_FLAG_INTERPOLATE* = 0x00000200
  orxSPAWNER_KU32_MASK_USER_ALL* = 0x000000FF

## * Event enum
##

type
  orxSPAWNER_EVENT* {.size: sizeof(cint).} = enum
    orxSPAWNER_EVENT_SPAWN = 0, orxSPAWNER_EVENT_CREATE, orxSPAWNER_EVENT_DELETE,
    orxSPAWNER_EVENT_RESET, orxSPAWNER_EVENT_EMPTY, orxSPAWNER_EVENT_WAVE_START,
    orxSPAWNER_EVENT_WAVE_STOP, orxSPAWNER_EVENT_NUMBER,
    orxSPAWNER_EVENT_NONE = orxENUM_NONE


## * Internal spawner structure

type
  orxSPAWNER* = SPAWNER_t

## * Spawner module setup
##

proc orxSpawner_Setup*() {.cdecl, importcpp: "orxSpawner_Setup(@)",
                         dynlib: "liborx.so".}
## * Inits the spawner module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_Init*(): orxSTATUS {.cdecl, importcpp: "orxSpawner_Init(@)",
                                  dynlib: "liborx.so".}
## * Exits from the spawner module
##

proc orxSpawner_Exit*() {.cdecl, importcpp: "orxSpawner_Exit(@)", dynlib: "liborx.so".}
## * Creates an empty spawner
##  @return orxSPAWNER / orxNULL
##

proc orxSpawner_Create*(): ptr orxSPAWNER {.cdecl, importcpp: "orxSpawner_Create(@)",
                                        dynlib: "liborx.so".}
## * Creates a spawner from config
##  @param[in]   _zConfigID    Config ID
##  @ return orxSPAWNER / orxNULL
##

proc orxSpawner_CreateFromConfig*(zConfigID: ptr orxCHAR): ptr orxSPAWNER {.cdecl,
    importcpp: "orxSpawner_CreateFromConfig(@)", dynlib: "liborx.so".}
## * Deletes a spawner
##  @param[in] _pstSpawner       Concerned spawner
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_Delete*(pstSpawner: ptr orxSPAWNER): orxSTATUS {.cdecl,
    importcpp: "orxSpawner_Delete(@)", dynlib: "liborx.so".}
## * Enables/disables a spawner
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _bEnable      Enable / disable
##

proc orxSpawner_Enable*(pstSpawner: ptr orxSPAWNER; bEnable: orxBOOL) {.cdecl,
    importcpp: "orxSpawner_Enable(@)", dynlib: "liborx.so".}
## * Is spawner enabled?
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      orxTRUE if enabled, orxFALSE otherwise
##

proc orxSpawner_IsEnabled*(pstSpawner: ptr orxSPAWNER): orxBOOL {.cdecl,
    importcpp: "orxSpawner_IsEnabled(@)", dynlib: "liborx.so".}
## * Resets (and disables) a spawner
##  @param[in]   _pstSpawner     Concerned spawner
##

proc orxSpawner_Reset*(pstSpawner: ptr orxSPAWNER) {.cdecl,
    importcpp: "orxSpawner_Reset(@)", dynlib: "liborx.so".}
## * Sets spawner total object limit
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _u32TotalObjectLimit Total object limit, 0 for unlimited
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetTotalObjectLimit*(pstSpawner: ptr orxSPAWNER;
                                    u32TotalObjectLimit: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxSpawner_SetTotalObjectLimit(@)", dynlib: "liborx.so".}
## * Sets spawner active object limit
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _u32ActiveObjectLimit Active object limit, 0 for unlimited
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetActiveObjectLimit*(pstSpawner: ptr orxSPAWNER;
                                     u32ActiveObjectLimit: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxSpawner_SetActiveObjectLimit(@)", dynlib: "liborx.so".}
## * Gets spawner total object limit
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      Total object limit, 0 for unlimited
##

proc orxSpawner_GetTotalObjectLimit*(pstSpawner: ptr orxSPAWNER): orxU32 {.cdecl,
    importcpp: "orxSpawner_GetTotalObjectLimit(@)", dynlib: "liborx.so".}
## * Gets spawner active object limit
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      Active object limit, 0 for unlimited
##

proc orxSpawner_GetActiveObjectLimit*(pstSpawner: ptr orxSPAWNER): orxU32 {.cdecl,
    importcpp: "orxSpawner_GetActiveObjectLimit(@)", dynlib: "liborx.so".}
## * Gets spawner total object count
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      Total object count
##

proc orxSpawner_GetTotalObjectCount*(pstSpawner: ptr orxSPAWNER): orxU32 {.cdecl,
    importcpp: "orxSpawner_GetTotalObjectCount(@)", dynlib: "liborx.so".}
## * Gets spawner active object count
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      Active object count
##

proc orxSpawner_GetActiveObjectCount*(pstSpawner: ptr orxSPAWNER): orxU32 {.cdecl,
    importcpp: "orxSpawner_GetActiveObjectCount(@)", dynlib: "liborx.so".}
## * Sets spawner wave size
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _u32WaveSize    Number of objects to spawn in a wave / 0 for deactivating wave mode
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetWaveSize*(pstSpawner: ptr orxSPAWNER; u32WaveSize: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxSpawner_SetWaveSize(@)", dynlib: "liborx.so".}
## * Sets spawner wave delay
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _fWaveDelay     Delay between two waves / -1 for deactivating wave mode
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetWaveDelay*(pstSpawner: ptr orxSPAWNER; fWaveDelay: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxSpawner_SetWaveDelay(@)", dynlib: "liborx.so".}
## * Gets spawner wave size
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      Number of objects spawned in a wave / 0 if not in wave mode
##

proc orxSpawner_GetWaveSize*(pstSpawner: ptr orxSPAWNER): orxU32 {.cdecl,
    importcpp: "orxSpawner_GetWaveSize(@)", dynlib: "liborx.so".}
## * Gets spawner wave delay
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      Delay between two waves / -1 if not in wave mode
##

proc orxSpawner_GetWaveDelay*(pstSpawner: ptr orxSPAWNER): orxFLOAT {.cdecl,
    importcpp: "orxSpawner_GetWaveDelay(@)", dynlib: "liborx.so".}
## * Gets spawner next wave delay
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      Delay before next wave is spawned / -1 if not in wave mode
##

proc orxSpawner_GetNextWaveDelay*(pstSpawner: ptr orxSPAWNER): orxFLOAT {.cdecl,
    importcpp: "orxSpawner_GetNextWaveDelay(@)", dynlib: "liborx.so".}
## * Sets spawner object speed
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _pvObjectSpeed  Speed to apply to every spawned object / orxNULL to not apply any speed
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetObjectSpeed*(pstSpawner: ptr orxSPAWNER;
                               pvObjectSpeed: ptr orxVECTOR): orxSTATUS {.cdecl,
    importcpp: "orxSpawner_SetObjectSpeed(@)", dynlib: "liborx.so".}
## * Gets spawner object speed
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _pvObjectSpeed  Speed applied to every spawned object
##  @return      Speed applied to every spawned object / orxNULL if none is applied
##

proc orxSpawner_GetObjectSpeed*(pstSpawner: ptr orxSPAWNER;
                               pvObjectSpeed: ptr orxVECTOR): ptr orxVECTOR {.cdecl,
    importcpp: "orxSpawner_GetObjectSpeed(@)", dynlib: "liborx.so".}
## * Spawns items
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _u32Number      Number of items to spawn
##  @return      Number of spawned items
##

proc orxSpawner_Spawn*(pstSpawner: ptr orxSPAWNER; u32Number: orxU32): orxU32 {.cdecl,
    importcpp: "orxSpawner_Spawn(@)", dynlib: "liborx.so".}
## * Gets spawner frame
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      orxFRAME
##

proc orxSpawner_GetFrame*(pstSpawner: ptr orxSPAWNER): ptr orxFRAME {.cdecl,
    importcpp: "orxSpawner_GetFrame(@)", dynlib: "liborx.so".}
## * Sets spawner position
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _pvPosition     Spawner position
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetPosition*(pstSpawner: ptr orxSPAWNER; pvPosition: ptr orxVECTOR): orxSTATUS {.
    cdecl, importcpp: "orxSpawner_SetPosition(@)", dynlib: "liborx.so".}
## * Sets spawner rotation
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _fRotation      Spawner rotation (radians)
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetRotation*(pstSpawner: ptr orxSPAWNER; fRotation: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxSpawner_SetRotation(@)", dynlib: "liborx.so".}
## * Sets spawner scale
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _pvScale        Spawner scale vector
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetScale*(pstSpawner: ptr orxSPAWNER; pvScale: ptr orxVECTOR): orxSTATUS {.
    cdecl, importcpp: "orxSpawner_SetScale(@)", dynlib: "liborx.so".}
## * Get spawner position
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[out]  _pvPosition     Spawner position
##  @return      orxVECTOR / orxNULL
##

proc orxSpawner_GetPosition*(pstSpawner: ptr orxSPAWNER; pvPosition: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxSpawner_GetPosition(@)", dynlib: "liborx.so".}
## * Get spawner world position
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[out]  _pvPosition     Spawner world position
##  @return      orxVECTOR / orxNULL
##

proc orxSpawner_GetWorldPosition*(pstSpawner: ptr orxSPAWNER;
                                 pvPosition: ptr orxVECTOR): ptr orxVECTOR {.cdecl,
    importcpp: "orxSpawner_GetWorldPosition(@)", dynlib: "liborx.so".}
## * Get spawner rotation
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      orxFLOAT (radians)
##

proc orxSpawner_GetRotation*(pstSpawner: ptr orxSPAWNER): orxFLOAT {.cdecl,
    importcpp: "orxSpawner_GetRotation(@)", dynlib: "liborx.so".}
## * Get spawner world rotation
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      orxFLOAT (radians)
##

proc orxSpawner_GetWorldRotation*(pstSpawner: ptr orxSPAWNER): orxFLOAT {.cdecl,
    importcpp: "orxSpawner_GetWorldRotation(@)", dynlib: "liborx.so".}
## * Get spawner scale
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[out]  _pvScale        Spawner scale vector
##  @return      Scale vector
##

proc orxSpawner_GetScale*(pstSpawner: ptr orxSPAWNER; pvScale: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxSpawner_GetScale(@)", dynlib: "liborx.so".}
## * Gets spawner world scale
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[out]  _pvScale        Spawner world scale
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_GetWorldScale*(pstSpawner: ptr orxSPAWNER; pvScale: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxSpawner_GetWorldScale(@)", dynlib: "liborx.so".}
## * Sets spawner parent
##  @param[in]   _pstSpawner     Concerned spawner
##  @param[in]   _pParent        Parent structure to set (object, spawner, camera or frame) / orxNULL
##  @return      orsSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSpawner_SetParent*(pstSpawner: ptr orxSPAWNER; pParent: pointer): orxSTATUS {.
    cdecl, importcpp: "orxSpawner_SetParent(@)", dynlib: "liborx.so".}
## * Gets spawner parent
##  @param[in]   _pstSpawner Concerned spawner
##  @return      Parent (object, spawner, camera or frame) / orxNULL
##

proc orxSpawner_GetParent*(pstSpawner: ptr orxSPAWNER): ptr orxSTRUCTURE {.cdecl,
    importcpp: "orxSpawner_GetParent(@)", dynlib: "liborx.so".}
## * Gets spawner name
##  @param[in]   _pstSpawner     Concerned spawner
##  @return      orxSTRING / orxSTRING_EMPTY
##

proc orxSpawner_GetName*(pstSpawner: ptr orxSPAWNER): ptr orxCHAR {.cdecl,
    importcpp: "orxSpawner_GetName(@)", dynlib: "liborx.so".}
## * @}
