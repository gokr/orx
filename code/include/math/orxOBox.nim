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
##  @file orxOBox.h
##  @date 03/10/2008
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxOBox
##
##  Oriented box module
##  Module that handles oriented boxes
##
##  @{
##

import
  orxInclude, math/orxVector

## * Public oriented box structure
##

type
  orxOBOX* {.bycopy.} = object
    vPosition*: orxVECTOR      ## *< Position vector  : 12
    vPivot*: orxVECTOR         ## *< Pivot vector     : 24
    vX*: orxVECTOR             ## *< X axis vector    : 36
    vY*: orxVECTOR             ## *< Y axis vector    : 48
    vZ*: orxVECTOR             ## *< Z axis vector    : 60


##  *** OBox inlined functions ***
## * Sets 2D oriented box values
##  @param[out]  _pstRes                       OBox to set
##  @param[in]   _pvWorldPosition              World space position vector
##  @param[in]   _pvPivot                      Pivot vector
##  @param[in]   _pvSize                       Size vector
##  @param[in]   _fAngle                       Z-axis angle (radians)
##  @return      orxOBOX / orxNULL
##

proc orxOBox_2DSet*(pstRes: ptr orxOBOX; pvWorldPosition: ptr orxVECTOR;
                   pvPivot: ptr orxVECTOR; pvSize: ptr orxVECTOR; fAngle: orxFLOAT): ptr orxOBOX {.
    cdecl.} =
  discard

## * Copies an OBox onto another one
##  @param[out]  _pstDst                       OBox to copy to (destination)
##  @param[in]   _pstSrc                       OBox to copy from (destination)
##  @return      Destination OBox
##

proc orxOBox_Copy*(pstDst: ptr orxOBOX; pstSrc: ptr orxOBOX): ptr orxOBOX {.cdecl.} =
  discard

## * Gets OBox center position
##  @param[in]   _pstOp                        Concerned OBox
##  @param[out]  _pvRes                        Center position
##  @return      Center position vector
##

proc orxOBox_GetCenter*(pstOp: ptr orxOBOX; pvRes: ptr orxVECTOR): ptr orxVECTOR {.cdecl.} =
  discard

## * Moves an OBox
##  @param[out]  _pstRes                       OBox where to store result
##  @param[in]   _pstOp                        OBox to move
##  @param[in]   _pvMove                       Move vector
##  @return      Moved OBox
##

proc orxOBox_Move*(pstRes: ptr orxOBOX; pstOp: ptr orxOBOX; pvMove: ptr orxVECTOR): ptr orxOBOX {.
    cdecl.} =
  discard

## * Rotates in 2D an OBox
##  @param[out]  _pstRes                       OBox where to store result
##  @param[in]   _pstOp                        OBox to rotate (its Z-axis vector will be unchanged)
##  @param[in]   _fAngle                       Z-axis rotation angle (radians)
##  @return      Rotated OBox
##

proc orxOBox_2DRotate*(pstRes: ptr orxOBOX; pstOp: ptr orxOBOX; fAngle: orxFLOAT): ptr orxOBOX {.
    cdecl.} =
  discard

## * Is position inside oriented box test
##  @param[in]   _pstBox                       Box to test against position
##  @param[in]   _pvPosition                   Position to test against the box
##  @return      orxTRUE if position is inside the box, orxFALSE otherwise
##

proc orxOBox_IsInside*(pstBox: ptr orxOBOX; pvPosition: ptr orxVECTOR): orxBOOL {.cdecl.} =
  discard

## * Is 2D position inside oriented box test
##  @param[in]   _pstBox                       Box to test against position
##  @param[in]   _pvPosition                   Position to test against the box (no Z-test)
##  @return      orxTRUE if position is inside the box, orxFALSE otherwise
##

proc orxOBox_2DIsInside*(pstBox: ptr orxOBOX; pvPosition: ptr orxVECTOR): orxBOOL {.
    cdecl.} =
  discard

## * Tests oriented box intersection (simple Z-axis test, to use with Z-axis aligned orxOBOX)
##  @param[in]   _pstBox1                      First box operand
##  @param[in]   _pstBox2                      Second box operand
##  @return      orxTRUE if boxes intersect, orxFALSE otherwise
##

proc orxOBox_ZAlignedTestIntersection*(pstBox1: ptr orxOBOX; pstBox2: ptr orxOBOX): orxBOOL {.
    cdecl.} =
  discard

## * @}
