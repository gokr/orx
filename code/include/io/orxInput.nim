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
##  @file orxInput.h
##  @date 04/11/2008
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxInput
##
##  Input module
##  Module that handles generalized inputs (keyboard, mouse, joystick, ...)
##
##  @{
##

import
  orxInclude, io/orxJoystick, io/orxKeyboard, io/orxMouse

## * Misc defines
##

const
  orxINPUT_KZ_CONFIG_SECTION* = "Input"
  orxINPUT_KZ_CONFIG_SET_LIST* = "SetList"
  orxINPUT_KZ_CONFIG_DEFAULT_THRESHOLD* = "DefaultThreshold"
  orxINPUT_KZ_CONFIG_DEFAULT_MULTIPLIER* = "DefaultMultiplier"
  orxINPUT_KZ_CONFIG_COMBINE_LIST* = "CombineList"
  orxINPUT_KU32_BINDING_NUMBER* = 8
  orxINPUT_KZ_INTERNAL_SET_PREFIX* = "-="
  orxINPUT_KC_MODE_PREFIX_POSITIVE* = '+'
  orxINPUT_KC_MODE_PREFIX_NEGATIVE* = '-'

template orxINPUT_GET_FLAG*(TYPE: untyped): untyped =
  ((orxU32)(1 shl (orxU32)(TYPE)))

const
  orxINPUT_KU32_FLAG_TYPE_NONE* = 0x00000000
  orxINPUT_KU32_MASK_TYPE_ALL* = 0x0000FFFF

## * Input type enum
##

type
  orxINPUT_TYPE* {.size: sizeof(cint).} = enum
    orxINPUT_TYPE_KEYBOARD_KEY = 0, orxINPUT_TYPE_MOUSE_BUTTON,
    orxINPUT_TYPE_MOUSE_AXIS, orxINPUT_TYPE_JOYSTICK_BUTTON,
    orxINPUT_TYPE_JOYSTICK_AXIS, orxINPUT_TYPE_EXTERNAL, orxINPUT_TYPE_NUMBER,
    orxINPUT_TYPE_NONE = orxENUM_NONE


## * Input mode enum
##

type
  orxINPUT_MODE* {.size: sizeof(cint).} = enum
    orxINPUT_MODE_FULL = 0, orxINPUT_MODE_POSITIVE, orxINPUT_MODE_NEGATIVE,
    orxINPUT_MODE_NUMBER, orxINPUT_MODE_NONE = orxENUM_NONE


## * Event enum
##

type
  orxINPUT_EVENT* {.size: sizeof(cint).} = enum
    orxINPUT_EVENT_ON = 0, orxINPUT_EVENT_OFF, orxINPUT_EVENT_SELECT_SET,
    orxINPUT_EVENT_NUMBER, orxINPUT_EVENT_NONE = orxENUM_NONE


## * Input event payload
##

type
  orxINPUT_EVENT_PAYLOAD* {.bycopy.} = object
    zSetName*: ptr orxCHAR      ## *< Set name : 4/8
    zInputName*: ptr orxCHAR    ## *< Input name : 8/16
    aeType*: array[orxINPUT_KU32_BINDING_NUMBER, orxINPUT_TYPE] ## *< Input binding type : 40/48
    aeID*: array[orxINPUT_KU32_BINDING_NUMBER, orxENUM] ## *< Input binding ID : 72/80
    aeMode*: array[orxINPUT_KU32_BINDING_NUMBER, orxINPUT_MODE] ## *< Input binding Mode : 104/112
    afValue*: array[orxINPUT_KU32_BINDING_NUMBER, orxFLOAT] ## *< Input binding value : 136/144


## * Input module setup
##

proc orxInput_Setup*() {.cdecl, importcpp: "orxInput_Setup(@)", dynlib: "liborx.so".}
## * Initializes Input module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_Init*(): orxSTATUS {.cdecl, importcpp: "orxInput_Init(@)",
                                dynlib: "liborx.so".}
## * Exits from Input module
##

proc orxInput_Exit*() {.cdecl, importcpp: "orxInput_Exit(@)", dynlib: "liborx.so".}
## * Loads inputs from config
##  @param[in] _zFileName        File name to load, will use current loaded config if orxSTRING_EMPTY/orxNULL
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_Load*(zFileName: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxInput_Load(@)", dynlib: "liborx.so".}
## * Saves inputs to config
##  @param[in] _zFileName        File name
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_Save*(zFileName: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxInput_Save(@)", dynlib: "liborx.so".}
## * Selects (and enables) current working set
##  @param[in] _zSetName         Set name to select
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_SelectSet*(zSetName: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxInput_SelectSet(@)", dynlib: "liborx.so".}
## * Gets current working set
##  @return Current selected set
##

proc orxInput_GetCurrentSet*(): ptr orxCHAR {.cdecl,
    importcpp: "orxInput_GetCurrentSet(@)", dynlib: "liborx.so".}
## * Enables/disables working set (without selecting it)
##  @param[in] _zSetName         Set name to enable/disable
##  @param[in] _bEnable          Enable / Disable
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_EnableSet*(zSetName: ptr orxCHAR; bEnable: orxBOOL): orxSTATUS {.cdecl,
    importcpp: "orxInput_EnableSet(@)", dynlib: "liborx.so".}
## * Is working set enabled (includes current working set)?
##  @param[in] _zSetName         Set name to check
##  @return orxTRUE / orxFALSE
##

proc orxInput_IsSetEnabled*(zSetName: ptr orxCHAR): orxBOOL {.cdecl,
    importcpp: "orxInput_IsSetEnabled(@)", dynlib: "liborx.so".}
## * Sets current set's type flags, only set types will be polled when updating the set (use orxINPUT_GET_FLAG(TYPE) in order to get the flag that matches a type)
##  @param[in] _u32AddTypeFlags      Type flags to add
##  @param[in] _u32RemoveTypeFlags   Type flags to remove
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_SetTypeFlags*(u32AddTypeFlags: orxU32; u32RemoveTypeFlags: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxInput_SetTypeFlags(@)", dynlib: "liborx.so".}
## * Is input active?
##  @param[in] _zInputName       Concerned input name
##  @return orxTRUE if active, orxFALSE otherwise
##

proc orxInput_IsActive*(zInputName: ptr orxCHAR): orxBOOL {.cdecl,
    importcpp: "orxInput_IsActive(@)", dynlib: "liborx.so".}
## * Has input been activated (this frame)?
##  @param[in] _zInputName       Concerned input name
##  @return orxTRUE if newly activated since last frame, orxFALSE otherwise
##

proc orxInput_HasBeenActivated*(zInputName: ptr orxCHAR): orxBOOL {.cdecl,
    importcpp: "orxInput_HasBeenActivated(@)", dynlib: "liborx.so".}
## * Has input been deactivated (this frame)?
##  @param[in] _zInputName       Concerned input name
##  @return orxTRUE if newly deactivated since last frame, orxFALSE otherwise
##

proc orxInput_HasBeenDeactivated*(zInputName: ptr orxCHAR): orxBOOL {.cdecl,
    importcpp: "orxInput_HasBeenDeactivated(@)", dynlib: "liborx.so".}
## * Has a new active status since this frame?
##  @param[in] _zInputName       Concerned input name
##  @return orxTRUE if active status is new, orxFALSE otherwise
##

proc orxInput_HasNewStatus*(zInputName: ptr orxCHAR): orxBOOL {.cdecl,
    importcpp: "orxInput_HasNewStatus(@)", dynlib: "liborx.so".}
## * Gets input value
##  @param[in] _zInputName       Concerned input name
##  @return orxFLOAT
##

proc orxInput_GetValue*(zInputName: ptr orxCHAR): orxFLOAT {.cdecl,
    importcpp: "orxInput_GetValue(@)", dynlib: "liborx.so".}
## * Sets input value (will prevail on peripheral inputs only once)
##  @param[in] _zInputName       Concerned input name
##  @param[in] _fValue           Value to set, orxFLOAT_0 to deactivate
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_SetValue*(zInputName: ptr orxCHAR; fValue: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxInput_SetValue(@)", dynlib: "liborx.so".}
## * Sets permanent input value (will prevail on peripheral inputs till reset)
##  @param[in] _zInputName       Concerned input name
##  @param[in] _fValue           Value to set, orxFLOAT_0 to deactivate
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_SetPermanentValue*(zInputName: ptr orxCHAR; fValue: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxInput_SetPermanentValue(@)", dynlib: "liborx.so".}
## * Resets input value (peripheral inputs will then be used instead of code ones)
##  @param[in] _zInputName       Concerned input name
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_ResetValue*(zInputName: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxInput_ResetValue(@)", dynlib: "liborx.so".}
## * Gets input threshold
##  @param[in] _zInputName       Concerned input name
##  @return Input threshold
##

proc orxInput_GetThreshold*(zInputName: ptr orxCHAR): orxFLOAT {.cdecl,
    importcpp: "orxInput_GetThreshold(@)", dynlib: "liborx.so".}
## * Sets input threshold, if not set the default global threshold will be used
##  @param[in] _zInputName       Concerned input name
##  @param[in] _fThreshold       Threshold value (between 0.0f and 1.0f)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_SetThreshold*(zInputName: ptr orxCHAR; fThreshold: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxInput_SetThreshold(@)", dynlib: "liborx.so".}
## * Gets input multiplier
##  @param[in] _zInputName       Concerned input name
##  @return Input multiplier
##

proc orxInput_GetMultiplier*(zInputName: ptr orxCHAR): orxFLOAT {.cdecl,
    importcpp: "orxInput_GetMultiplier(@)", dynlib: "liborx.so".}
## * Sets input multiplier, if not set the default global multiplier will be used
##  @param[in] _zInputName       Concerned input name
##  @param[in] _fMultiplier      Multiplier value, can be negative
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_SetMultiplier*(zInputName: ptr orxCHAR; fMultiplier: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxInput_SetMultiplier(@)", dynlib: "liborx.so".}
## * Sets an input combine mode
##  @param[in] _zName            Concerned input name
##  @param[in] _bCombine         If orxTRUE, all assigned bindings need to be active in order to activate input, otherwise input will be considered active if any of its binding is
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_SetCombineMode*(zName: ptr orxCHAR; bCombine: orxBOOL): orxSTATUS {.
    cdecl, importcpp: "orxInput_SetCombineMode(@)", dynlib: "liborx.so".}
## * Is an input in combine mode?
##  @param[in] _zName            Concerned input name
##  @return orxTRUE if the input is in combine mode, orxFALSE otherwise
##

proc orxInput_IsInCombineMode*(zName: ptr orxCHAR): orxBOOL {.cdecl,
    importcpp: "orxInput_IsInCombineMode(@)", dynlib: "liborx.so".}
## * Binds an input to a mouse/joystick button, keyboard key or joystick axis
##  @param[in] _zName            Concerned input name
##  @param[in] _eType            Type of peripheral to bind
##  @param[in] _eID              ID of button/key/axis to bind
##  @param[in] _eMode            Mode (only used for axis input)
##  @param[in] _s32BindingIndex  Index of the desired binding, if < 0 the oldest binding will be replaced
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_Bind*(zName: ptr orxCHAR; eType: orxINPUT_TYPE; eID: orxENUM;
                   eMode: orxINPUT_MODE; s32BindingIndex: orxS32): orxSTATUS {.cdecl,
    importcpp: "orxInput_Bind(@)", dynlib: "liborx.so".}
## * Unbinds an input
##  @param[in] _zName            Concerned input name
##  @param[in] _s32BindingIndex  Index of the desired binding, if < 0 all the bindings will be removed
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxInput_Unbind*(zName: ptr orxCHAR; s32BindingIndex: orxS32): orxSTATUS {.cdecl,
    importcpp: "orxInput_Unbind(@)", dynlib: "liborx.so".}
## * Gets the input count to which a mouse/joystick button, keyboard key or joystick axis is bound
##  @param[in] _eType            Type of peripheral to test
##  @param[in] _eID              ID of button/key/axis to test
##  @param[in] _eMode            Mode (only used for axis input)
##  @return Number of bound inputs
##

proc orxInput_GetBoundInputCount*(eType: orxINPUT_TYPE; eID: orxENUM;
                                 eMode: orxINPUT_MODE): orxU32 {.cdecl,
    importcpp: "orxInput_GetBoundInputCount(@)", dynlib: "liborx.so".}
## * Gets the input name to which a mouse/joystick button, keyboard key or joystick axis is bound (at given index)
##  @param[in] _eType            Type of peripheral to test
##  @param[in] _eID              ID of button/key/axis to test
##  @param[in] _eMode            Mode (only used for axis input)
##  @param[in] _u32InputIndex    Index of the desired input
##  @param[out] _pzName          Input name, mandatory
##  @param[out] _pu32BindingIndex Binding index for this input, ignored if orxNULL
##  @return orxSTATUS_SUCCESS if binding exists / orxSTATUS_FAILURE otherwise
##

proc orxInput_GetBoundInput*(eType: orxINPUT_TYPE; eID: orxENUM;
                            eMode: orxINPUT_MODE; u32InputIndex: orxU32;
                            pzName: ptr ptr orxCHAR; pu32BindingIndex: ptr orxU32): orxSTATUS {.
    cdecl, importcpp: "orxInput_GetBoundInput(@)", dynlib: "liborx.so".}
## * Gets an input binding (mouse/joystick button, keyboard key or joystick axis) at a given index
##  @param[in]   _zName            Concerned input name
##  @param[in]   _u32BindingIndex  Index of the desired binding, should be less than orxINPUT_KU32_BINDING_NUMBER
##  @param[out]  _peType           Binding type (if a slot is not bound, its value is orxINPUT_TYPE_NONE)
##  @param[out]  _peID             Binding ID (button/key/axis)
##  @param[out]  _peMode           Mode (only used for axis inputs)
##  @return orxSTATUS_SUCCESS if input exists, orxSTATUS_FAILURE otherwise
##

proc orxInput_GetBinding*(zName: ptr orxCHAR; u32BindingIndex: orxU32;
                         peType: ptr orxINPUT_TYPE; peID: ptr orxENUM;
                         peMode: ptr orxINPUT_MODE): orxSTATUS {.cdecl,
    importcpp: "orxInput_GetBinding(@)", dynlib: "liborx.so".}
## * Gets an input binding (mouse/joystick button, keyboard key or joystick axis) list
##  @param[in]   _zName          Concerned input name
##  @param[out]  _aeTypeList     List of binding types (if a slot is not bound, its value is orxINPUT_TYPE_NONE)
##  @param[out]  _aeIDList       List of binding IDs (button/key/axis)
##  @param[out]  _aeModeList     List of modes (only used for axis inputs)
##  @return orxSTATUS_SUCCESS if input exists, orxSTATUS_FAILURE otherwise
##

proc orxInput_GetBindingList*(zName: ptr orxCHAR; aeTypeList: array[
    orxINPUT_KU32_BINDING_NUMBER, orxINPUT_TYPE]; aeIDList: array[
    orxINPUT_KU32_BINDING_NUMBER, orxENUM]; aeModeList: array[
    orxINPUT_KU32_BINDING_NUMBER, orxINPUT_MODE]): orxSTATUS {.cdecl,
    importcpp: "orxInput_GetBindingList(@)", dynlib: "liborx.so".}
## * Gets a binding name, don't keep the result as is as it'll get overridden during the next call to this function
##  @param[in]   _eType          Binding type (mouse/joystick button, keyboard key or joystick axis)
##  @param[in]   _eID            Binding ID (ID of button/key/axis to bind)
##  @param[in]   _eMode          Mode (only used for axis input)
##  @return orxSTRING (binding's name) if success, orxSTRING_EMPTY otherwise
##

proc orxInput_GetBindingName*(eType: orxINPUT_TYPE; eID: orxENUM;
                             eMode: orxINPUT_MODE): ptr orxCHAR {.cdecl,
    importcpp: "orxInput_GetBindingName(@)", dynlib: "liborx.so".}
## * Gets a binding type and ID from its name
##  @param[in]   _zName          Concerned input name
##  @param[out]  _peType         Binding type (mouse/joystick button, keyboard key or joystick axis)
##  @param[out]  _peID           Binding ID (ID of button/key/axis to bind)
##  @param[out]  _peMode         Binding mode (only used for axis input)
##  @return orxSTATUS_SUCCESS if input is valid, orxSTATUS_FAILURE otherwise
##

proc orxInput_GetBindingType*(zName: ptr orxCHAR; peType: ptr orxINPUT_TYPE;
                             peID: ptr orxENUM; peMode: ptr orxINPUT_MODE): orxSTATUS {.
    cdecl, importcpp: "orxInput_GetBindingType(@)", dynlib: "liborx.so".}
## * Gets active binding (current pressed key/button/...) so as to allow on-the-fly user rebinding
##  @param[out]  _peType         Active binding's type (mouse/joystick button, keyboard key or joystick axis)
##  @param[out]  _peID           Active binding's ID (ID of button/key/axis to bind)
##  @param[out]  _pfValue        Active binding's value (optional)
##  @return orxSTATUS_SUCCESS if one active binding is found, orxSTATUS_FAILURE otherwise
##

proc orxInput_GetActiveBinding*(peType: ptr orxINPUT_TYPE; peID: ptr orxENUM;
                               pfValue: ptr orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxInput_GetActiveBinding(@)", dynlib: "liborx.so".}
## * @}
