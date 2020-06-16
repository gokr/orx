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
##  @file orxAABox.h
##  @date 03/10/2008
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxAABox
##
##  Axis-aligned box module
##  Module that handles axis-aligned boxes
##
##  @{
##

import
  orxInclude, math/orxVector

import
  base/orxType

## * Public structure definition
##

type
  orxAABOX* {.bycopy.} = object
    vTL*: orxVECTOR            ## *< Top left corner vector : 12
    vBR*: orxVECTOR            ## *< Bottom right corner vector : 24


##  *** AABox inlined functions ***
## * Reorders AABox corners
##  @param[in]   _pstBox                       Box to reorder
##  @return      Reordered AABox
##

proc orxAABox_Reorder*(pstBox: ptr orxAABOX): ptr orxAABOX {.cdecl.} =
  discard

## * Sets axis aligned box values
##  @param[out]  _pstRes                       AABox to set
##  @param[in]   _pvTL                         Top left corner
##  @param[in]   _pvBR                         Bottom right corner
##  @return      orxAABOX / orxNULL
##

proc orxAABox_Set*(pstRes: ptr orxAABOX; pvTL: ptr orxVECTOR; pvBR: ptr orxVECTOR): ptr orxAABOX {.
    cdecl.} =
  discard

## * Is position inside axis aligned box test
##  @param[in]   _pstBox                       Box to test against position
##  @param[in]   _pvPosition                   Position to test against the box
##  @return      orxTRUE if position is inside the box, orxFALSE otherwise
##

proc orxAABox_IsInside*(pstBox: ptr orxAABOX; pvPosition: ptr orxVECTOR): orxBOOL {.
    cdecl.} =
  discard

## * Tests axis aligned box intersection
##  @param[in]   _pstBox1                      First box operand
##  @param[in]   _pstBox2                      Second box operand
##  @return      orxTRUE if boxes intersect, orxFALSE otherwise
##

proc orxAABox_TestIntersection*(pstBox1: ptr orxAABOX; pstBox2: ptr orxAABOX): orxBOOL {.
    cdecl.} =
  discard

## * Tests axis aligned box 2D intersection (no Z-axis test)
##  @param[in]   _pstBox1                      First box operand
##  @param[in]   _pstBox2                      Second box operand
##  @return      orxTRUE if boxes intersect in 2D, orxFALSE otherwise
##

proc orxAABox_Test2DIntersection*(pstBox1: ptr orxAABOX; pstBox2: ptr orxAABOX): orxBOOL {.
    cdecl.} =
  discard

## * Copies an AABox onto another one
##  @param[out]   _pstDst                      AABox to copy to (destination)
##  @param[in]   _pstSrc                       AABox to copy from (destination)
##  @return      Destination AABox
##

proc orxAABox_Copy*(pstDst: ptr orxAABOX; pstSrc: ptr orxAABOX): ptr orxAABOX {.cdecl.} =
  discard

## * Moves an AABox
##  @param[out]  _pstRes                       AABox where to store result
##  @param[in]   _pstOp                        AABox to move
##  @param[in]   _pvMove                       Move vector
##  @return      Moved AABox
##

proc orxAABox_Move*(pstRes: ptr orxAABOX; pstOp: ptr orxAABOX; pvMove: ptr orxVECTOR): ptr orxAABOX {.
    cdecl.} =
  discard

## * Gets AABox center position
##  @param[in]   _pstOp                        Concerned AABox
##  @param[out]  _pvRes                        Center position
##  @return      Center position vector
##

proc orxAABox_GetCenter*(pstOp: ptr orxAABOX; pvRes: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * @}
