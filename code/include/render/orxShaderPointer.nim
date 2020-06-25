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
##  @file orxShaderPointer.h
##  @date 08/04/2009
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxShaderPointer
##
##  ShaderPointer module
##  Allows to creates shaders (rendering post effects) containers for objects.
##
##  @{
##

import
  orxInclude, render/orxShader, obj/orxStructure

import
  base/orxType

## * Misc defines
##

const
  orxSHADERPOINTER_KU32_SHADER_NUMBER* = 4

## * Internal ShaderPointer structure

type orxSHADERPOINTER* = object
## * ShaderPointer module setup
##

proc orxShaderPointer_Setup*() {.cdecl, importc: "orxShaderPointer_Setup",
                               dynlib: "liborx.so".}
## * Inits the ShaderPointer module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxShaderPointer_Init*(): orxSTATUS {.cdecl, importc: "orxShaderPointer_Init",
                                        dynlib: "liborx.so".}
## * Exits from the ShaderPointer module
##

proc orxShaderPointer_Exit*() {.cdecl, importc: "orxShaderPointer_Exit",
                              dynlib: "liborx.so".}
## * Creates an empty ShaderPointer
##  @return orxSHADERPOINTER / nil
##

proc orxShaderPointer_Create*(): ptr orxSHADERPOINTER {.cdecl,
    importc: "orxShaderPointer_Create", dynlib: "liborx.so".}
## * Deletes an ShaderPointer
##  @param[in] _pstShaderPointer     Concerned ShaderPointer
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxShaderPointer_Delete*(pstShaderPointer: ptr orxSHADERPOINTER): orxSTATUS {.
    cdecl, importc: "orxShaderPointer_Delete", dynlib: "liborx.so".}
## * Starts a ShaderPointer
##  @param[in] _pstShaderPointer     Concerned ShaderPointer
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxShaderPointer_Start*(pstShaderPointer: ptr orxSHADERPOINTER): orxSTATUS {.
    cdecl, importc: "orxShaderPointer_Start", dynlib: "liborx.so".}
## * Stops a ShaderPointer
##  @param[in] _pstShaderPointer     Concerned ShaderPointer
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxShaderPointer_Stop*(pstShaderPointer: ptr orxSHADERPOINTER): orxSTATUS {.
    cdecl, importc: "orxShaderPointer_Stop", dynlib: "liborx.so".}
## * Enables/disables an ShaderPointer
##  @param[in]   _pstShaderPointer   Concerned ShaderPointer
##  @param[in]   _bEnable        Enable / disable
##

proc orxShaderPointer_Enable*(pstShaderPointer: ptr orxSHADERPOINTER;
                             bEnable: orxBOOL) {.cdecl,
    importc: "orxShaderPointer_Enable", dynlib: "liborx.so".}
## * Is ShaderPointer enabled?
##  @param[in]   _pstShaderPointer   Concerned ShaderPointer
##  @return      orxTRUE if enabled, orxFALSE otherwise
##

proc orxShaderPointer_IsEnabled*(pstShaderPointer: ptr orxSHADERPOINTER): orxBOOL {.
    cdecl, importc: "orxShaderPointer_IsEnabled", dynlib: "liborx.so".}
## * Adds a shader
##  @param[in]   _pstShaderPointer Concerned ShaderPointer
##  @param[in]   _pstShader        Shader to add
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxShaderPointer_AddShader*(pstShaderPointer: ptr orxSHADERPOINTER;
                                pstShader: ptr orxSHADER): orxSTATUS {.cdecl,
    importc: "orxShaderPointer_AddShader", dynlib: "liborx.so".}
## * Removes a shader
##  @param[in]   _pstShaderPointer Concerned ShaderPointer
##  @param[in]   _pstShader        Shader to remove
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxShaderPointer_RemoveShader*(pstShaderPointer: ptr orxSHADERPOINTER;
                                   pstShader: ptr orxSHADER): orxSTATUS {.cdecl,
    importc: "orxShaderPointer_RemoveShader", dynlib: "liborx.so".}
## * Gets a shader
##  @param[in]   _pstShaderPointer Concerned ShaderPointer
##  @param[in]   _u32Index         Index of shader to get
##  @return      orxSHADER / nil
##

proc orxShaderPointer_GetShader*(pstShaderPointer: ptr orxSHADERPOINTER;
                                u32Index: orxU32): ptr orxSHADER {.cdecl,
    importc: "orxShaderPointer_GetShader", dynlib: "liborx.so".}
## * Adds a shader using its config ID
##  @param[in]   _pstShaderPointer Concerned ShaderPointer
##  @param[in]   _zShaderConfigID  Config ID of the shader to add
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxShaderPointer_AddShaderFromConfig*(
    pstShaderPointer: ptr orxSHADERPOINTER; zShaderConfigID: cstring): orxSTATUS {.
    cdecl, importc: "orxShaderPointer_AddShaderFromConfig", dynlib: "liborx.so".}
## * Removes a shader using its config ID
##  @param[in]   _pstShaderPointer Concerned ShaderPointer
##  @param[in]   _zShaderConfigID  Config ID of the shader to remove
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxShaderPointer_RemoveShaderFromConfig*(
    pstShaderPointer: ptr orxSHADERPOINTER; zShaderConfigID: cstring): orxSTATUS {.
    cdecl, importc: "orxShaderPointer_RemoveShaderFromConfig", dynlib: "liborx.so".}
## * @}
