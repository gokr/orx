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
##  @file orxTexture.h
##  @date 07/12/2003
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxTexture
##
##  Texture module
##  Module that handles textures
##
##  @{
##

import
  orxInclude, display/orxDisplay, math/orxMath

import
  base/orxType

## * Defines
##

const
  orxTEXTURE_KZ_RESOURCE_GROUP* = "Texture"
  orxTEXTURE_KZ_SCREEN* = "screen"
  orxTEXTURE_KZ_PIXEL* = "pixel"

## * Event enum
##

type
  orxTEXTURE_EVENT* {.size: sizeof(cint).} = enum
    orxTEXTURE_EVENT_CREATE = 0, orxTEXTURE_EVENT_DELETE, orxTEXTURE_EVENT_LOAD,
    orxTEXTURE_EVENT_NUMBER, orxTEXTURE_EVENT_NONE = orxENUM_NONE


## * Internal texture structure

type orxTEXTURE* = object
## * Setups the texture module
##

proc orxTexture_Setup*() {.cdecl, importc: "orxTexture_Setup", dynlib: "liborx.so".}
## * Inits the texture module
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTexture_Init*(): orxSTATUS {.cdecl, importc: "orxTexture_Init",
                                  dynlib: "liborx.so".}
## * Exits from the texture module
##

proc orxTexture_Exit*() {.cdecl, importc: "orxTexture_Exit", dynlib: "liborx.so".}
## * Creates an empty texture
##  @return      orxTEXTURE / nil
##

proc orxTexture_Create*(): ptr orxTEXTURE {.cdecl, importc: "orxTexture_Create",
                                        dynlib: "liborx.so".}
## * Creates a texture from a bitmap file
##  @param[in]   _zFileName      Name of the bitmap
##  @param[in]   _bKeepInCache   Should be kept in cache after no more references exist?
##  @return      orxTEXTURE / nil
##

proc orxTexture_CreateFromFile*(zFileName: cstring; bKeepInCache: orxBOOL): ptr orxTEXTURE {.
    cdecl, importc: "orxTexture_CreateFromFile", dynlib: "liborx.so".}
## * Deletes a texture (and its referenced bitmap)
##  @param[in]   _pstTexture     Concerned texture
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTexture_Delete*(pstTexture: ptr orxTEXTURE): orxSTATUS {.cdecl,
    importc: "orxTexture_Delete", dynlib: "liborx.so".}
## * Clears cache (if any texture is still in active use, it'll remain in memory until not referenced anymore)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTexture_ClearCache*(): orxSTATUS {.cdecl, importc: "orxTexture_ClearCache",
                                        dynlib: "liborx.so".}
## * Links a bitmap
##  @param[in]   _pstTexture     Concerned texture
##  @param[in]   _pstBitmap      Bitmap to link
##  @param[in]   _zDataName      Name associated with the bitmap (usually filename)
##  @param[in]   _bTransferOwnership If set to true, the texture will become the bitmap's owner and will have it deleted upon its own deletion
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTexture_LinkBitmap*(pstTexture: ptr orxTEXTURE; pstBitmap: ptr orxBITMAP;
                           zDataName: cstring; bTransferOwnership: orxBOOL): orxSTATUS {.
    cdecl, importc: "orxTexture_LinkBitmap", dynlib: "liborx.so".}
## * Unlinks (and deletes if not used anymore) a bitmap
##  @param[in]   _pstTexture     Concerned texture
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTexture_UnlinkBitmap*(pstTexture: ptr orxTEXTURE): orxSTATUS {.cdecl,
    importc: "orxTexture_UnlinkBitmap", dynlib: "liborx.so".}
## * Gets texture bitmap
##  @param[in]   _pstTexture     Concerned texture
##  @return      orxBITMAP / nil
##

proc orxTexture_GetBitmap*(pstTexture: ptr orxTEXTURE): ptr orxBITMAP {.cdecl,
    importc: "orxTexture_GetBitmap", dynlib: "liborx.so".}
## * Gets texture size
##  @param[in]   _pstTexture     Concerned texture
##  @param[out]  _pfWidth        Texture's width
##  @param[out]  _pfHeight       Texture's height
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTexture_GetSize*(pstTexture: ptr orxTEXTURE; pfWidth: ptr orxFLOAT;
                        pfHeight: ptr orxFLOAT): orxSTATUS {.cdecl,
    importc: "orxTexture_GetSize", dynlib: "liborx.so".}
## * Gets texture name
##  @param[in]   _pstTexture   Concerned texture
##  @return      Texture name / orxSTRING_EMPTY
##

proc orxTexture_GetName*(pstTexture: ptr orxTEXTURE): cstring {.cdecl,
    importc: "orxTexture_GetName", dynlib: "liborx.so".}
## * Gets screen texture
##  @return      Screen texture / nil
##

proc orxTexture_GetScreenTexture*(): ptr orxTEXTURE {.cdecl,
    importc: "orxTexture_GetScreenTexture", dynlib: "liborx.so".}
## * Gets pending load count
##  @return      Pending load count
##

proc orxTexture_GetLoadCount*(): orxU32 {.cdecl, importc: "orxTexture_GetLoadCount",
                                       dynlib: "liborx.so".}
## * @}
