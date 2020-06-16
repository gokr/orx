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
##  @file orxDisplay.h
##  @date 23/04/2003
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxDisplay
##
##  Display plugin module
##  Module that handles display
##
##  @{
##

import
  orxInclude, plugin/orxPluginCore, math/orxVector, math/orxOBox, memory/orxBank,
  utils/orxHashTable, utils/orxString, utils/orxLinkList

import
  base/orxType

## * Misc defines
##

type
  INNER_C_STRUCT_orxDisplay_68* {.bycopy.} = object
    u8R*: orxU8
    u8G*: orxU8
    u8B*: orxU8
    u8A*: orxU8

  INNER_C_UNION_orxDisplay_66* {.bycopy.} = object {.union.}
    ano_orxDisplay_69*: INNER_C_STRUCT_orxDisplay_68
    u32RGBA*: orxU32

  orxRGBA* {.bycopy.} = object
    ano_orxDisplay_72*: INNER_C_UNION_orxDisplay_66


template orx2RGBA*(R, G, B, A: untyped): untyped =
  orxRGBA_Set((orxU8)(R), (orxU8)(G), (orxU8)(B), (orxU8)(A))

template orxRGBA_R*(RGBA: untyped): untyped =
  RGBA.u8R

template orxRGBA_G*(RGBA: untyped): untyped =
  RGBA.u8G

template orxRGBA_B*(RGBA: untyped): untyped =
  RGBA.u8B

template orxRGBA_A*(RGBA: untyped): untyped =
  RGBA.u8A

const
  orxCOLOR_NORMALIZER* = (orx2F(1.0 / 255.0))
  orxCOLOR_DENORMALIZER* = (orx2F(255.0))

type orxBITMAP* = object
## * Vertex info structure
##

type
  orxDISPLAY_VERTEX* {.bycopy.} = object
    fX*: orxFLOAT
    fY*: orxFLOAT
    fU*: orxFLOAT
    fV*: orxFLOAT
    stRGBA*: orxRGBA


## * Transform structure
##

type
  orxDISPLAY_TRANSFORM* {.bycopy.} = object
    fSrcX*: orxFLOAT
    fSrcY*: orxFLOAT
    fDstX*: orxFLOAT
    fDstY*: orxFLOAT
    fRepeatX*: orxFLOAT
    fRepeatY*: orxFLOAT
    fScaleX*: orxFLOAT
    fScaleY*: orxFLOAT
    fRotation*: orxFLOAT


## * Primitive enum
##

type
  orxDISPLAY_PRIMITIVE* {.size: sizeof(cint).} = enum
    orxDISPLAY_PRIMITIVE_POINTS = 0, orxDISPLAY_PRIMITIVE_LINES,
    orxDISPLAY_PRIMITIVE_LINE_LOOP, orxDISPLAY_PRIMITIVE_LINE_STRIP,
    orxDISPLAY_PRIMITIVE_TRIANGLES, orxDISPLAY_PRIMITIVE_TRIANGLE_STRIP,
    orxDISPLAY_PRIMITIVE_TRIANGLE_FAN, orxDISPLAY_PRIMITIVE_NUMBER,
    orxDISPLAY_PRIMITIVE_NONE = orxENUM_NONE


## * Mesh structure
##

type
  orxDISPLAY_MESH* {.bycopy.} = object
    astVertexList*: ptr orxDISPLAY_VERTEX
    au16IndexList*: ptr orxU16
    u32VertexNumber*: orxU32
    u32IndexNumber*: orxU32
    ePrimitive*: orxDISPLAY_PRIMITIVE


## * Video mode structure
##

type
  orxDISPLAY_VIDEO_MODE* {.bycopy.} = object
    u32Width*: orxU32
    u32Height*: orxU32
    u32Depth*: orxU32
    u32RefreshRate*: orxU32
    bFullScreen*: orxBOOL


## * Character glyph structure
##

type
  orxCHARACTER_GLYPH* {.bycopy.} = object
    fX*: orxFLOAT
    fY*: orxFLOAT
    fWidth*: orxFLOAT


## * Character map structure
##

type
  orxCHARACTER_MAP* {.bycopy.} = object
    fCharacterHeight*: orxFLOAT
    pstCharacterBank*: ptr orxBANK
    pstCharacterTable*: ptr orxHASHTABLE


## * Bitmap smoothing enum
##

type
  orxDISPLAY_SMOOTHING* {.size: sizeof(cint).} = enum
    orxDISPLAY_SMOOTHING_DEFAULT = 0, orxDISPLAY_SMOOTHING_ON,
    orxDISPLAY_SMOOTHING_OFF, orxDISPLAY_SMOOTHING_NUMBER,
    orxDISPLAY_SMOOTHING_NONE = orxENUM_NONE


## * Bitmap blend enum
##

type
  orxDISPLAY_BLEND_MODE* {.size: sizeof(cint).} = enum
    orxDISPLAY_BLEND_MODE_ALPHA = 0, orxDISPLAY_BLEND_MODE_MULTIPLY,
    orxDISPLAY_BLEND_MODE_ADD, orxDISPLAY_BLEND_MODE_PREMUL,
    orxDISPLAY_BLEND_MODE_NUMBER, orxDISPLAY_BLEND_MODE_NONE = orxENUM_NONE


## * Color structure
##

type
  INNER_C_UNION_orxDisplay_209* {.bycopy.} = object {.union.}
    vRGB*: orxVECTOR           ## *< RGB components: 12
    vHSL*: orxVECTOR           ## *< HSL components: 12
    vHSV*: orxVECTOR           ## *< HSV components: 12

  orxCOLOR* {.bycopy.} = object
    ano_orxDisplay_212*: INNER_C_UNION_orxDisplay_209
    fAlpha*: orxFLOAT          ## *< Alpha component: 16


## * Config parameters
##

const
  orxDISPLAY_KZ_CONFIG_SECTION* = "Display"
  orxDISPLAY_KZ_CONFIG_WIDTH* = "ScreenWidth"
  orxDISPLAY_KZ_CONFIG_HEIGHT* = "ScreenHeight"
  orxDISPLAY_KZ_CONFIG_DEPTH* = "ScreenDepth"
  orxDISPLAY_KZ_CONFIG_POSITION* = "ScreenPosition"
  orxDISPLAY_KZ_CONFIG_REFRESH_RATE* = "RefreshRate"
  orxDISPLAY_KZ_CONFIG_FULLSCREEN* = "FullScreen"
  orxDISPLAY_KZ_CONFIG_ALLOW_RESIZE* = "AllowResize"
  orxDISPLAY_KZ_CONFIG_DECORATION* = "Decoration"
  orxDISPLAY_KZ_CONFIG_TITLE* = "Title"
  orxDISPLAY_KZ_CONFIG_SMOOTH* = "Smoothing"
  orxDISPLAY_KZ_CONFIG_VSYNC* = "VSync"
  orxDISPLAY_KZ_CONFIG_DEPTHBUFFER* = "DepthBuffer"
  orxDISPLAY_KZ_CONFIG_SHADER_VERSION* = "ShaderVersion"
  orxDISPLAY_KZ_CONFIG_SHADER_EXTENSION_LIST* = "ShaderExtensionList"
  orxDISPLAY_KZ_CONFIG_MONITOR* = "Monitor"
  orxDISPLAY_KZ_CONFIG_CURSOR* = "Cursor"
  orxDISPLAY_KZ_CONFIG_ICON_LIST* = "IconList"
  orxDISPLAY_KZ_CONFIG_FRAMEBUFFER_SIZE* = "FramebufferSize"
  orxDISPLAY_KZ_CONFIG_TEXTURE_UNIT_NUMBER* = "TextureUnitNumber"
  orxDISPLAY_KZ_CONFIG_DRAW_BUFFER_NUMBER* = "DrawBufferNumber"

## * Shader texture suffixes
##

const
  orxDISPLAY_KZ_SHADER_SUFFIX_TOP* = "_top"
  orxDISPLAY_KZ_SHADER_SUFFIX_LEFT* = "_left"
  orxDISPLAY_KZ_SHADER_SUFFIX_BOTTOM* = "_bottom"
  orxDISPLAY_KZ_SHADER_SUFFIX_RIGHT* = "_right"

## * Shader extension actions
##

const
  orxDISPLAY_KC_SHADER_EXTENSION_ADD* = '+'
  orxDISPLAY_KC_SHADER_EXTENSION_REMOVE* = '-'

## * Event enum
##

type
  orxDISPLAY_EVENT* {.size: sizeof(cint).} = enum
    orxDISPLAY_EVENT_SET_VIDEO_MODE = 0, orxDISPLAY_EVENT_LOAD_BITMAP,
    orxDISPLAY_EVENT_NUMBER, orxDISPLAY_EVENT_NONE = orxENUM_NONE


## * Display event payload
##

type
  INNER_C_STRUCT_orxDisplay_278* {.bycopy.} = object
    u32Width*: orxU32          ## *< Screen width : 4
    u32Height*: orxU32         ## *< Screen height : 8
    u32Depth*: orxU32          ## *< Screen depth : 12
    u32RefreshRate*: orxU32    ## *< Refresh rate: 16
    u32PreviousWidth*: orxU32  ## *< Previous screen width : 20
    u32PreviousHeight*: orxU32 ## *< Previous screen height : 24
    u32PreviousDepth*: orxU32  ## *< Previous screen depth : 28
    u32PreviousRefreshRate*: orxU32 ## *< Previous refresh rate : 32
    bFullScreen*: orxBOOL      ## *< FullScreen? : 36

  INNER_C_STRUCT_orxDisplay_292* {.bycopy.} = object
    zLocation*: ptr orxCHAR     ## *< File location : 40
    stFilenameID*: orxSTRINGID ## *< File name ID : 44
    u32ID*: orxU32             ## *< Bitmap (hardware texture) ID : 48

  INNER_C_UNION_orxDisplay_276* {.bycopy.} = object {.union.}
    stVideoMode*: INNER_C_STRUCT_orxDisplay_278
    stBitmap*: INNER_C_STRUCT_orxDisplay_292

  orxDISPLAY_EVENT_PAYLOAD* {.bycopy.} = object
    ano_orxDisplay_297*: INNER_C_UNION_orxDisplay_276


## **************************************************************************
##  Functions directly implemented by orx core
## *************************************************************************
## * Display module setup
##

proc orxDisplay_Setup*() {.cdecl, importcpp: "orxDisplay_Setup(@)",
                         dynlib: "liborx.so".}
## * Sets all components of an orxRGBA
##  @param[in]   _u8R            Red value to set
##  @param[in]   _u8G            Green value to set
##  @param[in]   _u8B            Blue value to set
##  @param[in]   _u8A            Alpha value to set
##  @return      orxRGBA
##

proc orxRGBA_Set*(u8R: orxU8; u8G: orxU8; u8B: orxU8; u8A: orxU8): orxRGBA {.cdecl.} =
  discard

## * Sets all components from an orxRGBA
##  @param[in]   _pstColor       Concerned color
##  @param[in]   _stRGBA         RGBA values to set
##  @return      orxCOLOR
##

proc orxColor_SetRGBA*(pstColor: ptr orxCOLOR; stRGBA: orxRGBA): ptr orxCOLOR {.cdecl.} =
  discard

## * Sets all components
##  @param[in]   _pstColor       Concerned color
##  @param[in]   _pvRGB          RGB components
##  @param[in]   _fAlpha         Normalized alpha component
##  @return      orxCOLOR
##

proc orxColor_Set*(pstColor: ptr orxCOLOR; pvRGB: ptr orxVECTOR; fAlpha: orxFLOAT): ptr orxCOLOR {.
    cdecl.} =
  discard

## * Sets RGB components
##  @param[in]   _pstColor       Concerned color
##  @param[in]   _pvRGB          RGB components
##  @return      orxCOLOR
##

proc orxColor_SetRGB*(pstColor: ptr orxCOLOR; pvRGB: ptr orxVECTOR): ptr orxCOLOR {.cdecl.} =
  discard

## * Sets alpha component
##  @param[in]   _pstColor       Concerned color
##  @param[in]   _fAlpha         Normalized alpha component
##  @return      orxCOLOR / orxNULL
##

proc orxColor_SetAlpha*(pstColor: ptr orxCOLOR; fAlpha: orxFLOAT): ptr orxCOLOR {.cdecl.} =
  discard

## * Gets orxRGBA from an orxCOLOR
##  @param[in]   _pstColor       Concerned color
##  @return      orxRGBA
##

proc orxColor_ToRGBA*(pstColor: ptr orxCOLOR): orxRGBA {.cdecl.} =
  discard

## * Copies an orxCOLOR into another one
##  @param[in]   _pstDst         Destination color
##  @param[in]   _pstSrc         Source color
##  @return      orxCOLOR
##

proc orxColor_Copy*(pstDst: ptr orxCOLOR; pstSrc: ptr orxCOLOR): ptr orxCOLOR {.cdecl.} =
  discard

## * Converts from RGB color space to HSL one
##  @param[in]   _pstDst         Destination color
##  @param[in]   _pstSrc         Source color
##  @return      orxCOLOR
##

proc orxColor_FromRGBToHSL*(pstDst: ptr orxCOLOR; pstSrc: ptr orxCOLOR): ptr orxCOLOR {.
    cdecl.} =
  discard

## * Converts from HSL color space to RGB one
##  @param[in]   _pstDst         Destination color
##  @param[in]   _pstSrc         Source color
##  @return      orxCOLOR
##

proc orxColor_FromHSLToRGB*(pstDst: ptr orxCOLOR; pstSrc: ptr orxCOLOR): ptr orxCOLOR {.
    cdecl.} =
  discard

## * Converts from RGB color space to HSV one
##  @param[in]   _pstDst         Destination color
##  @param[in]   _pstSrc         Source color
##  @return      orxCOLOR
##

proc orxColor_FromRGBToHSV*(pstDst: ptr orxCOLOR; pstSrc: ptr orxCOLOR): ptr orxCOLOR {.
    cdecl.} =
  discard

## * Converts from HSV color space to RGB one
##  @param[in]   _pstDst         Destination color
##  @param[in]   _pstSrc         Source color
##  @return      orxCOLOR
##

proc orxColor_FromHSVToRGB*(pstDst: ptr orxCOLOR; pstSrc: ptr orxCOLOR): ptr orxCOLOR {.
    cdecl.} =
  discard

## * Gets blend mode from a string
##  @param[in]    _zBlendMode                          String to evaluate
##  @return orxDISPLAY_BLEND_MODE
##

proc orxDisplay_GetBlendModeFromString*(zBlendMode: ptr orxCHAR): orxDISPLAY_BLEND_MODE {.
    cdecl, importcpp: "orxDisplay_GetBlendModeFromString(@)", dynlib: "liborx.so".}
## **************************************************************************
##  Functions extended by plugins
## *************************************************************************
## * Inits the display module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_Init*(): orxSTATUS {.cdecl, importcpp: "orxDisplay_Init(@)",
                                  dynlib: "liborx.so".}
## * Exits from the display module
##

proc orxDisplay_Exit*() {.cdecl, importcpp: "orxDisplay_Exit(@)", dynlib: "liborx.so".}
## * Swaps/flips bufers (display on screen the current frame)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_Swap*(): orxSTATUS {.cdecl, importcpp: "orxDisplay_Swap(@)",
                                  dynlib: "liborx.so".}
## * Gets screen bitmap
##  @return orxBITMAP / orxNULL
##

proc orxDisplay_GetScreenBitmap*(): ptr orxBITMAP {.cdecl,
    importcpp: "orxDisplay_GetScreenBitmap(@)", dynlib: "liborx.so".}
## * Gets screen size
##  @param[out]   _pfWidth                             Screen width
##  @param[out]   _pfHeight                            Screen height
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_GetScreenSize*(pfWidth: ptr orxFLOAT; pfHeight: ptr orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_GetScreenSize(@)", dynlib: "liborx.so".}
## * Creates a bitmap
##  @param[in]   _u32Width                             Bitmap width
##  @param[in]   _u32Height                            Bitmap height
##  @return orxBITMAP / orxNULL
##

proc orxDisplay_CreateBitmap*(u32Width: orxU32; u32Height: orxU32): ptr orxBITMAP {.
    cdecl, importcpp: "orxDisplay_CreateBitmap(@)", dynlib: "liborx.so".}
## * Deletes a bitmap
##  @param[in]   _pstBitmap                            Concerned bitmap
##

proc orxDisplay_DeleteBitmap*(pstBitmap: ptr orxBITMAP) {.cdecl,
    importcpp: "orxDisplay_DeleteBitmap(@)", dynlib: "liborx.so".}
## * Loads a bitmap from file (an event of ID orxDISPLAY_EVENT_BITMAP_LOAD will be sent upon completion, whether the loading is asynchronous or not)
##  @param[in]   _zFileName                            Name of the file to load
##  @return orxBITMAP * / orxNULL
##

proc orxDisplay_LoadBitmap*(zFileName: ptr orxCHAR): ptr orxBITMAP {.cdecl,
    importcpp: "orxDisplay_LoadBitmap(@)", dynlib: "liborx.so".}
## * Saves a bitmap to file
##  @param[in]   _pstBitmap                            Concerned bitmap
##  @param[in]   _zFileName                            Name of the file where to store the bitmap
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SaveBitmap*(pstBitmap: ptr orxBITMAP; zFileName: ptr orxCHAR): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_SaveBitmap(@)", dynlib: "liborx.so".}
## * Sets temp bitmap, if a valid temp bitmap is given, load operations will be asynchronous
##  @param[in]   _pstBitmap                            Concerned bitmap, orxNULL for forcing synchronous load operations
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetTempBitmap*(pstBitmap: ptr orxBITMAP): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_SetTempBitmap(@)", dynlib: "liborx.so".}
## * Gets current temp bitmap
##  @return orxBITMAP, if non-null, load operations are currently asynchronous, otherwise they're synchronous
##

proc orxDisplay_GetTempBitmap*(): ptr orxBITMAP {.cdecl,
    importcpp: "orxDisplay_GetTempBitmap(@)", dynlib: "liborx.so".}
## * Sets destination bitmaps
##  @param[in]   _apstBitmapList                       Destination bitmap list
##  @param[in]   _u32Number                            Number of destination bitmaps
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetDestinationBitmaps*(apstBitmapList: ptr ptr orxBITMAP;
                                      u32Number: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_SetDestinationBitmaps(@)", dynlib: "liborx.so".}
## * Clears a bitmap
##  @param[in]   _pstBitmap                            Concerned bitmap, if orxNULL all the current destination bitmaps will be cleared instead
##  @param[in]   _stColor                              Color to clear the bitmap with
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_ClearBitmap*(pstBitmap: ptr orxBITMAP; stColor: orxRGBA): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_ClearBitmap(@)", dynlib: "liborx.so".}
## * Sets current blend mode
##  @param[in]   _eBlendMode                           Blend mode to set
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetBlendMode*(eBlendMode: orxDISPLAY_BLEND_MODE): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_SetBlendMode(@)", dynlib: "liborx.so".}
## * Sets a bitmap clipping for blitting (both as source and destination)
##  @param[in]   _pstBitmap                            Concerned bitmap, orxNULL to target the first destination bitmap
##  @param[in]   _u32TLX                               Top left X coord in pixels
##  @param[in]   _u32TLY                               Top left Y coord in pixels
##  @param[in]   _u32BRX                               Bottom right X coord in pixels
##  @param[in]   _u32BRY                               Bottom right Y coord in pixels
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetBitmapClipping*(pstBitmap: ptr orxBITMAP; u32TLX: orxU32;
                                  u32TLY: orxU32; u32BRX: orxU32; u32BRY: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_SetBitmapClipping(@)", dynlib: "liborx.so".}
## * Sets a bitmap data (RGBA memory format)
##  @param[in]   _pstBitmap                            Concerned bitmap
##  @param[in]   _au8Data                              Data (4 channels, RGBA)
##  @param[in]   _u32ByteNumber                        Number of bytes
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetBitmapData*(pstBitmap: ptr orxBITMAP; au8Data: ptr orxU8;
                              u32ByteNumber: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_SetBitmapData(@)", dynlib: "liborx.so".}
## * Gets a bitmap data (RGBA memory format)
##  @param[in]   _pstBitmap                            Concerned bitmap
##  @param[in]   _au8Data                              Output buffer (4 channels, RGBA)
##  @param[in]   _u32ByteNumber                        Number of bytes of the buffer
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_GetBitmapData*(pstBitmap: ptr orxBITMAP; au8Data: ptr orxU8;
                              u32ByteNumber: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_GetBitmapData(@)", dynlib: "liborx.so".}
## * Sets a partial (rectangle) bitmap data (RGBA memory format)
##  @param[in]   _pstBitmap                            Concerned bitmap
##  @param[in]   _au8Data                              Data (4 channels, RGBA)
##  @param[in]   _u32X                                 Origin's X coord of the rectangle area to set
##  @param[in]   _u32Y                                 Origin's Y coord of the rectangle area to set
##  @param[in]   _u32Width                             Width of the rectangle area to set
##  @param[in]   _u32Height                            Height of the rectangle area to set
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetPartialBitmapData*(pstBitmap: ptr orxBITMAP; au8Data: ptr orxU8;
                                     u32X: orxU32; u32Y: orxU32; u32Width: orxU32;
                                     u32Height: orxU32): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_SetPartialBitmapData(@)", dynlib: "liborx.so".}
## * Gets a bitmap size
##  @param[in]   _pstBitmap                            Concerned bitmap
##  @param[out]  _pfWidth                              Bitmap width
##  @param[out]  _pfHeight                             Bitmap height
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_GetBitmapSize*(pstBitmap: ptr orxBITMAP; pfWidth: ptr orxFLOAT;
                              pfHeight: ptr orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_GetBitmapSize(@)", dynlib: "liborx.so".}
## * Gets a bitmap (internal) ID
##  @param[in]   _pstBitmap                            Concerned bitmap
##  @return orxU32
##

proc orxDisplay_GetBitmapID*(pstBitmap: ptr orxBITMAP): orxU32 {.cdecl,
    importcpp: "orxDisplay_GetBitmapID(@)", dynlib: "liborx.so".}
## * Transforms (and blits onto another) a bitmap
##  @param[in]   _pstSrc                               Bitmap to transform and draw
##  @param[in]   _pstTransform                         Transformation info (position, scale, rotation, ...)
##  @param[in]   _stColor                              Color
##  @param[in]   _eSmoothing                           Bitmap smoothing type
##  @param[in]   _eBlendMode                           Blend mode
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_TransformBitmap*(pstSrc: ptr orxBITMAP;
                                pstTransform: ptr orxDISPLAY_TRANSFORM;
                                stColor: orxRGBA;
                                eSmoothing: orxDISPLAY_SMOOTHING;
                                eBlendMode: orxDISPLAY_BLEND_MODE): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_TransformBitmap(@)", dynlib: "liborx.so".}
## * Transforms a text (onto a bitmap)
##  @param[in]   _zString                              String to display
##  @param[in]   _pstFont                              Font bitmap
##  @param[in]   _pstMap                               Character map
##  @param[in]   _pstTransform                         Transformation info (position, scale, rotation, ...)
##  @param[in]   _stColor                              Color
##  @param[in]   _eSmoothing                           Bitmap smoothing type
##  @param[in]   _eBlendMode                           Blend mode
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_TransformText*(zString: ptr orxCHAR; pstFont: ptr orxBITMAP;
                              pstMap: ptr orxCHARACTER_MAP;
                              pstTransform: ptr orxDISPLAY_TRANSFORM;
                              stColor: orxRGBA; eSmoothing: orxDISPLAY_SMOOTHING;
                              eBlendMode: orxDISPLAY_BLEND_MODE): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_TransformText(@)", dynlib: "liborx.so".}
## * Draws a line
##  @param[in]   _pvStart                              Start point
##  @param[in]   _pvEnd                                End point
##  @param[in]   _stColor                              Color
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_DrawLine*(pvStart: ptr orxVECTOR; pvEnd: ptr orxVECTOR;
                         stColor: orxRGBA): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_DrawLine(@)", dynlib: "liborx.so".}
## * Draws a polyline (aka open polygon)
##  @param[in]   _avVertexList                         List of vertices
##  @param[in]   _u32VertexNumber                      Number of vertices in the list
##  @param[in]   _stColor                              Color
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_DrawPolyline*(avVertexList: ptr orxVECTOR; u32VertexNumber: orxU32;
                             stColor: orxRGBA): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_DrawPolyline(@)", dynlib: "liborx.so".}
## * Draws a (closed) polygon; filled polygons *need* to be either convex or star-shaped concave with the first vertex part of the polygon's kernel
##  @param[in]   _avVertexList                         List of vertices
##  @param[in]   _u32VertexNumber                      Number of vertices in the list
##  @param[in]   _stColor                              Color
##  @param[in]   _bFill                                If true, the polygon will be filled otherwise only its outline will be drawn
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_DrawPolygon*(avVertexList: ptr orxVECTOR; u32VertexNumber: orxU32;
                            stColor: orxRGBA; bFill: orxBOOL): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_DrawPolygon(@)", dynlib: "liborx.so".}
## * Draws a circle
##  @param[in]   _pvCenter                             Center
##  @param[in]   _fRadius                              Radius
##  @param[in]   _stColor                              Color
##  @param[in]   _bFill                                If true, the polygon will be filled otherwise only its outline will be drawn
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_DrawCircle*(pvCenter: ptr orxVECTOR; fRadius: orxFLOAT;
                           stColor: orxRGBA; bFill: orxBOOL): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_DrawCircle(@)", dynlib: "liborx.so".}
## * Draws an oriented box
##  @param[in]   _pstBox                               Box to draw
##  @param[in]   _stColor                              Color
##  @param[in]   _bFill                                If true, the polygon will be filled otherwise only its outline will be drawn
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_DrawOBox*(pstBox: ptr orxOBOX; stColor: orxRGBA; bFill: orxBOOL): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_DrawOBox(@)", dynlib: "liborx.so".}
## * Draws a textured mesh
##  @param[in]   _pstMesh                              Mesh to draw, if no primitive and no index buffer is given, separate quads arrangement will be assumed
##  @param[in]   _pstBitmap                            Bitmap to use for texturing, orxNULL to use the current one
##  @param[in]   _eSmoothing                           Bitmap smoothing type
##  @param[in]   _eBlendMode                           Blend mode
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_DrawMesh*(pstMesh: ptr orxDISPLAY_MESH; pstBitmap: ptr orxBITMAP;
                         eSmoothing: orxDISPLAY_SMOOTHING;
                         eBlendMode: orxDISPLAY_BLEND_MODE): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_DrawMesh(@)", dynlib: "liborx.so".}
## * Has shader support?
##  @return orxTRUE / orxFALSE
##

proc orxDisplay_HasShaderSupport*(): orxBOOL {.cdecl,
    importcpp: "orxDisplay_HasShaderSupport(@)", dynlib: "liborx.so".}
## * Creates (compiles) a shader
##  @param[in]   _azCodeList                           List of shader code to compile, in order
##  @param[in]   _u32Size                              Size of the shader code list
##  @param[in]   _pstParamList                         Shader parameters (should be a link list of orxSHADER_PARAM)
##  @param[in]   _bUseCustomParam                      Shader uses custom parameters
##  @return orxHANDLE of the compiled shader is successful, orxHANDLE_UNDEFINED otherwise
##

proc orxDisplay_CreateShader*(azCodeList: ptr ptr orxCHAR; u32Size: orxU32;
                             pstParamList: ptr orxLINKLIST;
                             bUseCustomParam: orxBOOL): orxHANDLE {.cdecl,
    importcpp: "orxDisplay_CreateShader(@)", dynlib: "liborx.so".}
## * Deletes a compiled shader
##  @param[in]   _hShader                              Shader to delete
##

proc orxDisplay_DeleteShader*(hShader: orxHANDLE) {.cdecl,
    importcpp: "orxDisplay_DeleteShader(@)", dynlib: "liborx.so".}
## * Starts a shader rendering
##  @param[in]   _hShader                              Shader to start
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_StartShader*(hShader: orxHANDLE): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_StartShader(@)", dynlib: "liborx.so".}
## * Stops a shader rendering
##  @param[in]   _hShader                              Shader to stop
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_StopShader*(hShader: orxHANDLE): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_StopShader(@)", dynlib: "liborx.so".}
## * Gets a shader parameter's ID
##  @param[in]   _hShader                              Concerned shader
##  @param[in]   _zParam                               Parameter name
##  @param[in]   _s32Index                             Parameter index, -1 for non-array types
##  @param[in]   _bIsTexture                           Is parameter a texture?
##  @return Parameter ID
##

proc orxDisplay_GetParameterID*(hShader: orxHANDLE; zParam: ptr orxCHAR;
                               s32Index: orxS32; bIsTexture: orxBOOL): orxS32 {.
    cdecl, importcpp: "orxDisplay_GetParameterID(@)", dynlib: "liborx.so".}
## * Sets a shader parameter (orxBITMAP)
##  @param[in]   _hShader                              Concerned shader
##  @param[in]   _s32ID                                ID of parameter to set
##  @param[in]   _pstValue                             Value (orxBITMAP) for this parameter
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetShaderBitmap*(hShader: orxHANDLE; s32ID: orxS32;
                                pstValue: ptr orxBITMAP): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_SetShaderBitmap(@)", dynlib: "liborx.so".}
## * Sets a shader parameter (orxFLOAT)
##  @param[in]   _hShader                              Concerned shader
##  @param[in]   _s32ID                                ID of parameter to set
##  @param[in]   _fValue                               Value (orxFLOAT) for this parameter
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetShaderFloat*(hShader: orxHANDLE; s32ID: orxS32; fValue: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_SetShaderFloat(@)", dynlib: "liborx.so".}
## * Sets a shader parameter (orxVECTOR)
##  @param[in]   _hShader                              Concerned shader
##  @param[in]   _s32ID                                ID of parameter to set
##  @param[in]   _pvValue                              Value (orxVECTOR) for this parameter
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetShaderVector*(hShader: orxHANDLE; s32ID: orxS32;
                                pvValue: ptr orxVECTOR): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_SetShaderVector(@)", dynlib: "liborx.so".}
## * Enables / disables vertical synchro
##  @param[in]   _bEnable                              Enable / disable
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_EnableVSync*(bEnable: orxBOOL): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_EnableVSync(@)", dynlib: "liborx.so".}
## * Is vertical synchro enabled?
##  @return orxTRUE if enabled, orxFALSE otherwise
##

proc orxDisplay_IsVSyncEnabled*(): orxBOOL {.cdecl,
    importcpp: "orxDisplay_IsVSyncEnabled(@)", dynlib: "liborx.so".}
## * Sets full screen mode
##  @param[in]   _bFullScreen                          orxTRUE / orxFALSE
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetFullScreen*(bFullScreen: orxBOOL): orxSTATUS {.cdecl,
    importcpp: "orxDisplay_SetFullScreen(@)", dynlib: "liborx.so".}
## * Is in full screen mode?
##  @return orxTRUE if full screen, orxFALSE otherwise
##

proc orxDisplay_IsFullScreen*(): orxBOOL {.cdecl, importcpp: "orxDisplay_IsFullScreen(@)",
                                        dynlib: "liborx.so".}
## * Gets available video mode count
##  @return Available video mode count
##

proc orxDisplay_GetVideoModeCount*(): orxU32 {.cdecl,
    importcpp: "orxDisplay_GetVideoModeCount(@)", dynlib: "liborx.so".}
## * Gets an available video mode
##  @param[in]   _u32Index                             Video mode index, pass _u32Index < orxDisplay_GetVideoModeCount() for an available listed mode, orxU32_UNDEFINED for the the default (desktop) mode and any other value for current mode
##  @param[out]  _pstVideoMode                         Storage for the video mode
##  @return orxDISPLAY_VIDEO_MODE / orxNULL if invalid
##

proc orxDisplay_GetVideoMode*(u32Index: orxU32;
                             pstVideoMode: ptr orxDISPLAY_VIDEO_MODE): ptr orxDISPLAY_VIDEO_MODE {.
    cdecl, importcpp: "orxDisplay_GetVideoMode(@)", dynlib: "liborx.so".}
## * Gets an available video mode
##  @param[in]  _pstVideoMode                          Video mode to set
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxDisplay_SetVideoMode*(pstVideoMode: ptr orxDISPLAY_VIDEO_MODE): orxSTATUS {.
    cdecl, importcpp: "orxDisplay_SetVideoMode(@)", dynlib: "liborx.so".}
## * Is video mode available
##  @param[in]  _pstVideoMode                          Video mode to test
##  @return orxTRUE is available, orxFALSE otherwise
##

proc orxDisplay_IsVideoModeAvailable*(pstVideoMode: ptr orxDISPLAY_VIDEO_MODE): orxBOOL {.
    cdecl, importcpp: "orxDisplay_IsVideoModeAvailable(@)", dynlib: "liborx.so".}
## * @}
