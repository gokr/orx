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
##  @file orxViewport.h
##  @date 14/12/2003
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxViewport
##
##  Viewport module
##  Allows to creates and handle viewports.
##  Viewports are structures associated to cameras and used for rendering.
##
##  @{
##

import
  orxInclude, core/orxClock, render/orxCamera, render/orxShaderPointer,
  display/orxDisplay, display/orxTexture

import
  base/orxType, math/orxAABox

## * Viewport flags
##

const
  orxVIEWPORT_KU32_FLAG_ALIGN_CENTER* = 0x00000000
  orxVIEWPORT_KU32_FLAG_ALIGN_LEFT* = 0x10000000
  orxVIEWPORT_KU32_FLAG_ALIGN_RIGHT* = 0x20000000
  orxVIEWPORT_KU32_FLAG_ALIGN_TOP* = 0x40000000
  orxVIEWPORT_KU32_FLAG_ALIGN_BOTTOM* = 0x80000000
  orxVIEWPORT_KU32_FLAG_NO_DEBUG* = 0x01000000

## * Misc defined
##

const
  orxVIEWPORT_KU32_MAX_TEXTURE_NUMBER* = 8

## * Internal Viewport structure

type orxVIEWPORT* = object
## * Event enum
##

type
  orxVIEWPORT_EVENT* {.size: sizeof(cint).} = enum
    orxVIEWPORT_EVENT_RESIZE = 0, ## *< Event sent when a viewport has been resized
    orxVIEWPORT_EVENT_NUMBER, orxVIEWPORT_EVENT_NONE = orxENUM_NONE


## * Viewport module setup
##

proc orxViewport_Setup*() {.cdecl, importcpp: "orxViewport_Setup(@)",
                          dynlib: "liborx.so".}
## * Inits the viewport module
##

proc orxViewport_Init*(): orxSTATUS {.cdecl, importcpp: "orxViewport_Init(@)",
                                   dynlib: "liborx.so".}
## * Exits from the viewport module
##

proc orxViewport_Exit*() {.cdecl, importcpp: "orxViewport_Exit(@)",
                         dynlib: "liborx.so".}
## * Creates a viewport
##  @return      Created orxVIEWPORT / orxNULL
##

proc orxViewport_Create*(): ptr orxVIEWPORT {.cdecl,
    importcpp: "orxViewport_Create(@)", dynlib: "liborx.so".}
## * Creates a viewport from config
##  @param[in]   _zConfigID    Config ID
##  @ return orxVIEWPORT / orxNULL
##

proc orxViewport_CreateFromConfig*(zConfigID: ptr orxCHAR): ptr orxVIEWPORT {.cdecl,
    importcpp: "orxViewport_CreateFromConfig(@)", dynlib: "liborx.so".}
## * Deletes a viewport
##  @param[in]   _pstViewport    Viewport to delete
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxViewport_Delete*(pstViewport: ptr orxVIEWPORT): orxSTATUS {.cdecl,
    importcpp: "orxViewport_Delete(@)", dynlib: "liborx.so".}
## * Sets a viewport texture list
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _u32TextureNumber Number of textures to associate with the viewport
##  @param[in]   _apstTextureList List of textures to associate with the viewport
##

proc orxViewport_SetTextureList*(pstViewport: ptr orxVIEWPORT;
                                u32TextureNumber: orxU32;
                                apstTextureList: ptr ptr orxTEXTURE) {.cdecl,
    importcpp: "orxViewport_SetTextureList(@)", dynlib: "liborx.so".}
## * Gets a viewport texture list
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _u32TextureNumber Number of textures to be retrieved
##  @param[out]  _apstTextureList List of textures associated with the viewport
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxViewport_GetTextureList*(pstViewport: ptr orxVIEWPORT;
                                u32TextureNumber: orxU32;
                                apstTextureList: ptr ptr orxTEXTURE): orxSTATUS {.
    cdecl, importcpp: "orxViewport_GetTextureList(@)", dynlib: "liborx.so".}
## * Gets a viewport texture count
##  @param[in]   _pstViewport    Concerned viewport
##  @return      Number of textures associated with the viewport
##

proc orxViewport_GetTextureCount*(pstViewport: ptr orxVIEWPORT): orxU32 {.cdecl,
    importcpp: "orxViewport_GetTextureCount(@)", dynlib: "liborx.so".}
## * Sets a viewport background color
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _pstColor        Color to use for background
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxViewport_SetBackgroundColor*(pstViewport: ptr orxVIEWPORT;
                                    pstColor: ptr orxCOLOR): orxSTATUS {.cdecl,
    importcpp: "orxViewport_SetBackgroundColor(@)", dynlib: "liborx.so".}
## * Clears viewport background color
##  @param[in]   _pstViewport    Concerned viewport
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxViewport_ClearBackgroundColor*(pstViewport: ptr orxVIEWPORT): orxSTATUS {.
    cdecl, importcpp: "orxViewport_ClearBackgroundColor(@)", dynlib: "liborx.so".}
## * Viewport has background color accessor
##  @param[in]   _pstViewport    Concerned viewport
##  @return      orxTRUE / orxFALSE
##

proc orxViewport_HasBackgroundColor*(pstViewport: ptr orxVIEWPORT): orxBOOL {.cdecl,
    importcpp: "orxViewport_HasBackgroundColor(@)", dynlib: "liborx.so".}
## * Gets a viewport background color
##  @param[in]   _pstViewport    Concerned viewport
##  @param[out]  _pstColor       Viewport's color
##  @return      Current background color
##

proc orxViewport_GetBackgroundColor*(pstViewport: ptr orxVIEWPORT;
                                    pstColor: ptr orxCOLOR): ptr orxCOLOR {.cdecl,
    importcpp: "orxViewport_GetBackgroundColor(@)", dynlib: "liborx.so".}
## * Enables / disables a viewport
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _bEnable        Enable / disable
##

proc orxViewport_Enable*(pstViewport: ptr orxVIEWPORT; bEnable: orxBOOL) {.cdecl,
    importcpp: "orxViewport_Enable(@)", dynlib: "liborx.so".}
## * Is a viewport enabled?
##  @param[in]   _pstViewport    Concerned viewport
##  @return      orxTRUE / orxFALSE
##

proc orxViewport_IsEnabled*(pstViewport: ptr orxVIEWPORT): orxBOOL {.cdecl,
    importcpp: "orxViewport_IsEnabled(@)", dynlib: "liborx.so".}
## * Sets a viewport camera
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _pstCamera      Associated camera
##

proc orxViewport_SetCamera*(pstViewport: ptr orxVIEWPORT; pstCamera: ptr orxCAMERA) {.
    cdecl, importcpp: "orxViewport_SetCamera(@)", dynlib: "liborx.so".}
## * Gets a viewport camera
##  @param[in]   _pstViewport    Concerned viewport
##  @return      Associated camera / orxNULL
##

proc orxViewport_GetCamera*(pstViewport: ptr orxVIEWPORT): ptr orxCAMERA {.cdecl,
    importcpp: "orxViewport_GetCamera(@)", dynlib: "liborx.so".}
## * Adds a shader to a viewport using its config ID
##  @param[in]   _pstViewport      Concerned viewport
##  @param[in]   _zShaderConfigID  Config ID of the shader to add
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxViewport_AddShader*(pstViewport: ptr orxVIEWPORT;
                           zShaderConfigID: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxViewport_AddShader(@)", dynlib: "liborx.so".}
## * Removes a shader using its config ID
##  @param[in]   _pstViewport      Concerned viewport
##  @param[in]   _zShaderConfigID Config ID of the shader to remove
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxViewport_RemoveShader*(pstViewport: ptr orxVIEWPORT;
                              zShaderConfigID: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxViewport_RemoveShader(@)", dynlib: "liborx.so".}
## * Enables a viewport's shader
##  @param[in]   _pstViewport      Concerned viewport
##  @param[in]   _bEnable          Enable / disable
##

proc orxViewport_EnableShader*(pstViewport: ptr orxVIEWPORT; bEnable: orxBOOL) {.
    cdecl, importcpp: "orxViewport_EnableShader(@)", dynlib: "liborx.so".}
## * Is a viewport's shader enabled?
##  @param[in]   _pstViewport      Concerned viewport
##  @return      orxTRUE if enabled, orxFALSE otherwise
##

proc orxViewport_IsShaderEnabled*(pstViewport: ptr orxVIEWPORT): orxBOOL {.cdecl,
    importcpp: "orxViewport_IsShaderEnabled(@)", dynlib: "liborx.so".}
## * Gets a viewport's shader pointer
##  @param[in]   _pstViewport      Concerned viewport
##  @return      orxSHADERPOINTER / orxNULL
##

proc orxViewport_GetShaderPointer*(pstViewport: ptr orxVIEWPORT): ptr orxSHADERPOINTER {.
    cdecl, importcpp: "orxViewport_GetShaderPointer(@)", dynlib: "liborx.so".}
## * Sets a viewport blend mode (only used when has active shaders attached)
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _eBlendMode     Blend mode to set
##

proc orxViewport_SetBlendMode*(pstViewport: ptr orxVIEWPORT;
                              eBlendMode: orxDISPLAY_BLEND_MODE): orxSTATUS {.
    cdecl, importcpp: "orxViewport_SetBlendMode(@)", dynlib: "liborx.so".}
## * Gets a viewport blend mode
##  @param[in]   _pstViewport    Concerned viewport
##  @return orxDISPLAY_BLEND_MODE
##

proc orxViewport_GetBlendMode*(pstViewport: ptr orxVIEWPORT): orxDISPLAY_BLEND_MODE {.
    cdecl, importcpp: "orxViewport_GetBlendMode(@)", dynlib: "liborx.so".}
## * Sets a viewport position
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _fX             X axis position (top left corner)
##  @param[in]   _fY             Y axis position (top left corner)
##

proc orxViewport_SetPosition*(pstViewport: ptr orxVIEWPORT; fX: orxFLOAT; fY: orxFLOAT) {.
    cdecl, importcpp: "orxViewport_SetPosition(@)", dynlib: "liborx.so".}
## * Sets a viewport relative position
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _u32AlignFlags  Alignment flags
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxViewport_SetRelativePosition*(pstViewport: ptr orxVIEWPORT;
                                     u32AlignFlags: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxViewport_SetRelativePosition(@)", dynlib: "liborx.so".}
## * Gets a viewport position
##  @param[in]   _pstViewport    Concerned viewport
##  @param[out]  _pfX            X axis position (top left corner)
##  @param[out]  _pfY            Y axis position (top left corner)
##

proc orxViewport_GetPosition*(pstViewport: ptr orxVIEWPORT; pfX: ptr orxFLOAT;
                             pfY: ptr orxFLOAT) {.cdecl,
    importcpp: "orxViewport_GetPosition(@)", dynlib: "liborx.so".}
## * Sets a viewport size
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _fWidth         Width
##  @param[in]   _fHeight        Height
##

proc orxViewport_SetSize*(pstViewport: ptr orxVIEWPORT; fWidth: orxFLOAT;
                         fHeight: orxFLOAT) {.cdecl,
    importcpp: "orxViewport_SetSize(@)", dynlib: "liborx.so".}
## * Sets a viewport relative size
##  @param[in]   _pstViewport    Concerned viewport
##  @param[in]   _fWidth         Relative width (0.0f - 1.0f)
##  @param[in]   _fHeight        Relative height (0.0f - 1.0f)
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxViewport_SetRelativeSize*(pstViewport: ptr orxVIEWPORT; fWidth: orxFLOAT;
                                 fHeight: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxViewport_SetRelativeSize(@)", dynlib: "liborx.so".}
## * Gets a viewport size
##  @param[in]   _pstViewport    Concerned viewport
##  @param[out]  _pfWidth        Width
##  @param[out]  _pfHeight       Height
##

proc orxViewport_GetSize*(pstViewport: ptr orxVIEWPORT; pfWidth: ptr orxFLOAT;
                         pfHeight: ptr orxFLOAT) {.cdecl,
    importcpp: "orxViewport_GetSize(@)", dynlib: "liborx.so".}
## * Gets a viewport relative size
##  @param[in]   _pstViewport    Concerned viewport
##  @param[out]  _pfWidth        Relative width
##  @param[out]  _pfHeight       Relative height
##

proc orxViewport_GetRelativeSize*(pstViewport: ptr orxVIEWPORT;
                                 pfWidth: ptr orxFLOAT; pfHeight: ptr orxFLOAT) {.
    cdecl, importcpp: "orxViewport_GetRelativeSize(@)", dynlib: "liborx.so".}
## * Gets an axis aligned box of viewport
##  @param[in]   _pstViewport    Concerned viewport
##  @param[out]  _pstBox         Output box
##  @return orxAABOX / orxNULL
##

proc orxViewport_GetBox*(pstViewport: ptr orxVIEWPORT; pstBox: ptr orxAABOX): ptr orxAABOX {.
    cdecl, importcpp: "orxViewport_GetBox(@)", dynlib: "liborx.so".}
## * Get viewport correction ratio
##  @param[in]   _pstViewport  Concerned viewport
##  @return      Correction ratio value
##

proc orxViewport_GetCorrectionRatio*(pstViewport: ptr orxVIEWPORT): orxFLOAT {.cdecl,
    importcpp: "orxViewport_GetCorrectionRatio(@)", dynlib: "liborx.so".}
## * Gets viewport config name
##  @param[in]   _pstViewport    Concerned viewport
##  @return      orxSTRING / orxSTRING_EMPTY
##

proc orxViewport_GetName*(pstViewport: ptr orxVIEWPORT): ptr orxCHAR {.cdecl,
    importcpp: "orxViewport_GetName(@)", dynlib: "liborx.so".}
## * Gets viewport given its name
##  @param[in]   _zName          Camera name
##  @return      orxVIEWPORT / orxNULL
##

proc orxViewport_Get*(zName: ptr orxCHAR): ptr orxVIEWPORT {.cdecl,
    importcpp: "orxViewport_Get(@)", dynlib: "liborx.so".}
## * @}
