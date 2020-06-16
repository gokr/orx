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
##  @file orxFX.h
##  @date 30/06/2008
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxFX
##
##  FX module
##  Allows to creates rendering special effects affecting color, scale, rotation and position of visuals.
##
##  @{
##

import
  orxInclude, math/orxVector, obj/orxObject

import
  base/orxType

## * Slot flags
##

const
  orxFX_SLOT_KU32_FLAG_ABSOLUTE* = 0x00000100
  orxFX_SLOT_KU32_FLAG_USE_ROTATION* = 0x00000200
  orxFX_SLOT_KU32_FLAG_USE_SCALE* = 0x00000400

## * FX curve enum
##

type
  orxFX_CURVE* {.size: sizeof(cint).} = enum
    orxFX_CURVE_LINEAR = 0, orxFX_CURVE_SMOOTH, orxFX_CURVE_SMOOTHER,
    orxFX_CURVE_TRIANGLE, orxFX_CURVE_SINE, orxFX_CURVE_SQUARE, orxFX_CURVE_NUMBER,
    orxFX_CURVE_NONE = orxENUM_NONE


## * Internal FX structure
##

type orxFX* = object
## * Event enum
##

type
  orxFX_EVENT* {.size: sizeof(cint).} = enum
    orxFX_EVENT_START = 0,      ## *< Event sent when a FX starts
    orxFX_EVENT_STOP,         ## *< Event sent when a FX stops
    orxFX_EVENT_ADD,          ## *< Event sent when a FX is added
    orxFX_EVENT_REMOVE,       ## *< Event sent when a FX is removed
    orxFX_EVENT_LOOP,         ## *< Event sent when a FX is looping
    orxFX_EVENT_NUMBER, orxFX_EVENT_NONE = orxENUM_NONE


## * FX event payload
##

type
  orxFX_EVENT_PAYLOAD* {.bycopy.} = object
    pstFX*: ptr orxFX           ## *< FX reference : 4
    zFXName*: ptr orxCHAR       ## *< FX name : 8


## * FX module setup
##

proc orxFX_Setup*() {.cdecl, importcpp: "orxFX_Setup(@)", dynlib: "liborx.so".}
## * Inits the FX module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_Init*(): orxSTATUS {.cdecl, importcpp: "orxFX_Init(@)", dynlib: "liborx.so".}
## * Exits from the FX module
##

proc orxFX_Exit*() {.cdecl, importcpp: "orxFX_Exit(@)", dynlib: "liborx.so".}
## * Creates an empty FX
##  @return orxFX / orxNULL
##

proc orxFX_Create*(): ptr orxFX {.cdecl, importcpp: "orxFX_Create(@)",
                              dynlib: "liborx.so".}
## * Creates an FX from config
##  @param[in]   _zConfigID    Config ID
##  @ return orxFX / orxNULL
##

proc orxFX_CreateFromConfig*(zConfigID: ptr orxCHAR): ptr orxFX {.cdecl,
    importcpp: "orxFX_CreateFromConfig(@)", dynlib: "liborx.so".}
## * Deletes an FX
##  @param[in] _pstFX            Concerned FX
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_Delete*(pstFX: ptr orxFX): orxSTATUS {.cdecl, importcpp: "orxFX_Delete(@)",
    dynlib: "liborx.so".}
## * Clears cache (if any FX is still in active use, it'll remain in memory until not referenced anymore)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_ClearCache*(): orxSTATUS {.cdecl, importcpp: "orxFX_ClearCache(@)",
                                   dynlib: "liborx.so".}
## * Applies FX on object
##  @param[in] _pstFX            FX to apply
##  @param[in] _pstObject        Object on which to apply the FX
##  @param[in] _fStartTime       FX local application start time
##  @param[in] _fEndTime         FX local application end time
##  @return    orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_Apply*(pstFX: ptr orxFX; pstObject: ptr orxOBJECT; fStartTime: orxFLOAT;
                 fEndTime: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxFX_Apply(@)", dynlib: "liborx.so".}
## * Enables/disables an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _bEnable        Enable / disable
##

proc orxFX_Enable*(pstFX: ptr orxFX; bEnable: orxBOOL) {.cdecl,
    importcpp: "orxFX_Enable(@)", dynlib: "liborx.so".}
## * Is FX enabled?
##  @param[in]   _pstFX          Concerned FX
##  @return      orxTRUE if enabled, orxFALSE otherwise
##

proc orxFX_IsEnabled*(pstFX: ptr orxFX): orxBOOL {.cdecl,
    importcpp: "orxFX_IsEnabled(@)", dynlib: "liborx.so".}
## * Adds alpha to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _fStartAlpha    Starting alpha value
##  @param[in]   _fEndAlpha      Ending alpha value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddAlpha*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                    fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                    fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                    fStartAlpha: orxFLOAT; fEndAlpha: orxFLOAT; eCurve: orxFX_CURVE;
                    fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxFX_AddAlpha(@)", dynlib: "liborx.so".}
## * Adds RGB color to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _pvStartColor   Starting color value
##  @param[in]   _pvEndColor     Ending color value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddRGB*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                  fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                  fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                  pvStartColor: ptr orxVECTOR; pvEndColor: ptr orxVECTOR;
                  eCurve: orxFX_CURVE; fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxFX_AddRGB(@)", dynlib: "liborx.so".}
## * Adds HSL color to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _pvStartColor   Starting color value
##  @param[in]   _pvEndColor     Ending color value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddHSL*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                  fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                  fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                  pvStartColor: ptr orxVECTOR; pvEndColor: ptr orxVECTOR;
                  eCurve: orxFX_CURVE; fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxFX_AddHSL(@)", dynlib: "liborx.so".}
## * Adds HSV color to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _pvStartColor   Starting color value
##  @param[in]   _pvEndColor     Ending color value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddHSV*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                  fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                  fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                  pvStartColor: ptr orxVECTOR; pvEndColor: ptr orxVECTOR;
                  eCurve: orxFX_CURVE; fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxFX_AddHSV(@)", dynlib: "liborx.so".}
## * Adds rotation to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _fStartRotation Starting rotation value (radians)
##  @param[in]   _fEndRotation   Ending rotation value (radians)
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddRotation*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                       fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                       fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                       fStartRotation: orxFLOAT; fEndRotation: orxFLOAT;
                       eCurve: orxFX_CURVE; fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxFX_AddRotation(@)", dynlib: "liborx.so".}
## * Adds scale to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _pvStartScale   Starting scale value
##  @param[in]   _pvEndScale     Ending scale value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddScale*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                    fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                    fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                    pvStartScale: ptr orxVECTOR; pvEndScale: ptr orxVECTOR;
                    eCurve: orxFX_CURVE; fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxFX_AddScale(@)", dynlib: "liborx.so".}
## * Adds position to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _pvStartTranslation Starting position value
##  @param[in]   _pvEndTranslation Ending position value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddPosition*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                       fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                       fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                       pvStartTranslation: ptr orxVECTOR;
                       pvEndTranslation: ptr orxVECTOR; eCurve: orxFX_CURVE;
                       fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxFX_AddPosition(@)", dynlib: "liborx.so".}
## * Adds speed to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _pvStartSpeed   Starting speed value
##  @param[in]   _pvEndSpeed     Ending speed value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddSpeed*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                    fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                    fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                    pvStartSpeed: ptr orxVECTOR; pvEndSpeed: ptr orxVECTOR;
                    eCurve: orxFX_CURVE; fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxFX_AddSpeed(@)", dynlib: "liborx.so".}
## * Adds volume to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _fStartVolume   Starting volume value
##  @param[in]   _fEndVolume     Ending volume value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddVolume*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                     fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                     fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                     fStartVolume: orxFLOAT; fEndVolume: orxFLOAT;
                     eCurve: orxFX_CURVE; fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxFX_AddVolume(@)", dynlib: "liborx.so".}
## * Adds pitch to an FX
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _fStartTime     Time start
##  @param[in]   _fEndTime       Time end
##  @param[in]   _fCyclePeriod   Cycle period
##  @param[in]   _fCyclePhase    Cycle phase (at start)
##  @param[in]   _fAmplification Curve linear amplification over time (1.0 for none)
##  @param[in]   _fAcceleration  Curve linear acceleration over time (1.0 for none)
##  @param[in]   _fStartPitch    Starting pitch value
##  @param[in]   _fEndPitch      Ending pitch value
##  @param[in]   _eCurve         Blending curve type
##  @param[in]   _fPow           Blending curve exponent
##  @param[in]   _u32Flags       Param flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddPitch*(pstFX: ptr orxFX; fStartTime: orxFLOAT; fEndTime: orxFLOAT;
                    fCyclePeriod: orxFLOAT; fCyclePhase: orxFLOAT;
                    fAmplification: orxFLOAT; fAcceleration: orxFLOAT;
                    fStartPitch: orxFLOAT; fEndPitch: orxFLOAT; eCurve: orxFX_CURVE;
                    fPow: orxFLOAT; u32Flags: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxFX_AddPitch(@)", dynlib: "liborx.so".}
## * Adds a slot to an FX from config
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _zSlotID        Config ID
##  return       orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_AddSlotFromConfig*(pstFX: ptr orxFX; zSlotID: ptr orxCHAR): orxSTATUS {.
    cdecl, importcpp: "orxFX_AddSlotFromConfig(@)", dynlib: "liborx.so".}
## * Gets FX duration
##  @param[in]   _pstFX          Concerned FX
##  @return      orxFLOAT
##

proc orxFX_GetDuration*(pstFX: ptr orxFX): orxFLOAT {.cdecl,
    importcpp: "orxFX_GetDuration(@)", dynlib: "liborx.so".}
## * Gets FX name
##  @param[in]   _pstFX          Concerned FX
##  @return      orxSTRING / orxSTRING_EMPTY
##

proc orxFX_GetName*(pstFX: ptr orxFX): ptr orxCHAR {.cdecl,
    importcpp: "orxFX_GetName(@)", dynlib: "liborx.so".}
## * Set FX loop property
##  @param[in]   _pstFX          Concerned FX
##  @param[in]   _bLoop          Loop / don't loop
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFX_Loop*(pstFX: ptr orxFX; bLoop: orxBOOL): orxSTATUS {.cdecl,
    importcpp: "orxFX_Loop(@)", dynlib: "liborx.so".}
## * Is FX looping
##  @param[in]   _pstFX          Concerned FX
##  @return      orxTRUE if looping, orxFALSE otherwise
##

proc orxFX_IsLooping*(pstFX: ptr orxFX): orxBOOL {.cdecl,
    importcpp: "orxFX_IsLooping(@)", dynlib: "liborx.so".}
## * @}
