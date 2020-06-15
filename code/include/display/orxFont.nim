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
##  @file orxFont.h
##  @date 08/03/2010
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxFont
##
##  Font module
##  Module that handles fonts
##
##  @{
##

import
  orxInclude, display/orxTexture, math/orxVector

## * Misc defines
##

const
  orxFONT_KZ_DEFAULT_FONT_NAME* = "default"

## * Internal font structure

type
  orxFONT* = FONT_t

## * Setups the font module
##

proc orxFont_Setup*() {.cdecl, importcpp: "orxFont_Setup(@)", dynlib: "liborx.so".}
## * Inits the font module
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_Init*(): orxSTATUS {.cdecl, importcpp: "orxFont_Init(@)",
                               dynlib: "liborx.so".}
## * Exits from the font module
##

proc orxFont_Exit*() {.cdecl, importcpp: "orxFont_Exit(@)", dynlib: "liborx.so".}
## * Creates an empty font
##  @return      orxFONT / orxNULL
##

proc orxFont_Create*(): ptr orxFONT {.cdecl, importcpp: "orxFont_Create(@)",
                                  dynlib: "liborx.so".}
## * Creates a font from config
##  @param[in]   _zConfigID    Config ID
##  @return      orxFONT / orxNULL
##

proc orxFont_CreateFromConfig*(zConfigID: ptr orxCHAR): ptr orxFONT {.cdecl,
    importcpp: "orxFont_CreateFromConfig(@)", dynlib: "liborx.so".}
## * Deletes a font
##  @param[in]   _pstFont      Concerned font
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_Delete*(pstFont: ptr orxFONT): orxSTATUS {.cdecl,
    importcpp: "orxFont_Delete(@)", dynlib: "liborx.so".}
## * Gets default font
##  @return      Default font / orxNULL
##

proc orxFont_GetDefaultFont*(): ptr orxFONT {.cdecl,
    importcpp: "orxFont_GetDefaultFont(@)", dynlib: "liborx.so".}
## * Sets font's texture
##  @param[in]   _pstFont      Concerned font
##  @param[in]   _pstTexture   Texture to set
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_SetTexture*(pstFont: ptr orxFONT; pstTexture: ptr orxTEXTURE): orxSTATUS {.
    cdecl, importcpp: "orxFont_SetTexture(@)", dynlib: "liborx.so".}
## * Sets font's character list
##  @param[in]   _pstFont      Concerned font
##  @param[in]   _zList        Character list
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_SetCharacterList*(pstFont: ptr orxFONT; zList: ptr orxCHAR): orxSTATUS {.
    cdecl, importcpp: "orxFont_SetCharacterList(@)", dynlib: "liborx.so".}
## * Sets font's character height
##  @param[in]   _pstFont              Concerned font
##  @param[in]   _fCharacterHeight     Character's height
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_SetCharacterHeight*(pstFont: ptr orxFONT; fCharacterHeight: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxFont_SetCharacterHeight(@)", dynlib: "liborx.so".}
## * Sets font's character width list
##  @param[in]   _pstFont              Concerned font
##  @param[in]   _u32CharacterNumber   Character's number
##  @param[in]   _afCharacterWidthList List of widths for all the characters
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_SetCharacterWidthList*(pstFont: ptr orxFONT;
                                   u32CharacterNumber: orxU32;
                                   afCharacterWidthList: ptr orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxFont_SetCharacterWidthList(@)", dynlib: "liborx.so".}
## * Sets font's character spacing
##  @param[in]   _pstFont      Concerned font
##  @param[in]   _pvSpacing    Character's spacing
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_SetCharacterSpacing*(pstFont: ptr orxFONT; pvSpacing: ptr orxVECTOR): orxSTATUS {.
    cdecl, importcpp: "orxFont_SetCharacterSpacing(@)", dynlib: "liborx.so".}
## * Sets font's origin
##  @param[in]   _pstFont      Concerned font
##  @param[in]   _pvOrigin     Font's origin
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_SetOrigin*(pstFont: ptr orxFONT; pvOrigin: ptr orxVECTOR): orxSTATUS {.
    cdecl, importcpp: "orxFont_SetOrigin(@)", dynlib: "liborx.so".}
## * Sets font's size
##  @param[in]   _pstFont      Concerned font
##  @param[in]   _pvSize       Font's size
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFont_SetSize*(pstFont: ptr orxFONT; pvSize: ptr orxVECTOR): orxSTATUS {.cdecl,
    importcpp: "orxFont_SetSize(@)", dynlib: "liborx.so".}
## * Gets font's texture
##  @param[in]   _pstFont      Concerned font
##  @return      Font texture / orxNULL
##

proc orxFont_GetTexture*(pstFont: ptr orxFONT): ptr orxTEXTURE {.cdecl,
    importcpp: "orxFont_GetTexture(@)", dynlib: "liborx.so".}
## * Gets font's character list
##  @param[in]   _pstFont      Concerned font
##  @return      Font's character list / orxNULL
##

proc orxFont_GetCharacterList*(pstFont: ptr orxFONT): ptr orxCHAR {.cdecl,
    importcpp: "orxFont_GetCharacterList(@)", dynlib: "liborx.so".}
## * Gets font's character height
##  @param[in]   _pstFont                Concerned font
##  @return      orxFLOAT
##

proc orxFont_GetCharacterHeight*(pstFont: ptr orxFONT): orxFLOAT {.cdecl,
    importcpp: "orxFont_GetCharacterHeight(@)", dynlib: "liborx.so".}
## * Gets font's character width
##  @param[in]   _pstFont                Concerned font
##  @param[in]   _u32CharacterCodePoint  Character code point
##  @return      orxFLOAT
##

proc orxFont_GetCharacterWidth*(pstFont: ptr orxFONT; u32CharacterCodePoint: orxU32): orxFLOAT {.
    cdecl, importcpp: "orxFont_GetCharacterWidth(@)", dynlib: "liborx.so".}
## * Gets font's character spacing
##  @param[in]   _pstFont      Concerned font
##  @param[out]  _pvSpacing    Character's spacing
##  @return      orxVECTOR / orxNULL
##

proc orxFont_GetCharacterSpacing*(pstFont: ptr orxFONT; pvSpacing: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxFont_GetCharacterSpacing(@)", dynlib: "liborx.so".}
## * Gets font's origin
##  @param[in]   _pstFont      Concerned font
##  @param[out]  _pvOrigin     Font's origin
##  @return      orxVECTOR / orxNULL
##

proc orxFont_GetOrigin*(pstFont: ptr orxFONT; pvOrigin: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxFont_GetOrigin(@)", dynlib: "liborx.so".}
## * Gets font's size
##  @param[in]   _pstFont      Concerned font
##  @param[out]  _pvSize       Font's size
##  @return      orxVECTOR / orxNULL
##

proc orxFont_GetSize*(pstFont: ptr orxFONT; pvSize: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxFont_GetSize(@)", dynlib: "liborx.so".}
## * Gets font's map
##  @param[in]   _pstFont      Concerned font
##  @return      orxCHARACTER_MAP / orxNULL
##

proc orxFont_GetMap*(pstFont: ptr orxFONT): ptr orxCHARACTER_MAP {.cdecl,
    importcpp: "orxFont_GetMap(@)", dynlib: "liborx.so".}
## * Gets font name
##  @param[in]   _pstFont      Concerned font
##  @return      Font name / orxSTRING_EMPTY
##

proc orxFont_GetName*(pstFont: ptr orxFONT): ptr orxCHAR {.cdecl,
    importcpp: "orxFont_GetName(@)", dynlib: "liborx.so".}
## * @}
