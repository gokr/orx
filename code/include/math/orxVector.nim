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
##  @file orxVector.h
##  @date 30/03/2005
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxVector
##
##  Vector module
##  Module that handles vectors and basic structures based on them
##
##  @{
##

import
  orxInclude, debug/orxDebug, memory/orxMemory, math/orxMath

import
  base/orxType

## * Public structure definition
##

type
  INNER_C_UNION_orxVector_72* {.bycopy.} = object {.union.}
    fX*: orxFLOAT              ## *< First coordinate in the cartesian space
    fRho*: orxFLOAT            ## *< First coordinate in the spherical space
    fR*: orxFLOAT              ## *< First coordinate in the RGB color space
    fH*: orxFLOAT              ## *< First coordinate in the HSL/HSV color spaces

  INNER_C_UNION_orxVector_80* {.bycopy.} = object {.union.}
    fY*: orxFLOAT              ## *< Second coordinate in the cartesian space
    fTheta*: orxFLOAT          ## *< Second coordinate in the spherical space
    fG*: orxFLOAT              ## *< Second coordinate in the RGB color space
    fS*: orxFLOAT              ## *< Second coordinate in the HSL/HSV color spaces

  INNER_C_UNION_orxVector_88* {.bycopy.} = object {.union.}
    fZ*: orxFLOAT              ## *< Third coordinate in the cartesian space
    fPhi*: orxFLOAT            ## *< Third coordinate in the spherical space
    fB*: orxFLOAT              ## *< Third coordinate in the RGB color space
    fL*: orxFLOAT              ## *< Third coordinate in the HSL color space
    fV*: orxFLOAT              ## *< Third coordinate in the HSV color space

  orxVECTOR* {.bycopy.} = object
    ano_orxVector_76*: INNER_C_UNION_orxVector_72 ## * Coordinates : 12
    ano_orxVector_84*: INNER_C_UNION_orxVector_80
    ano_orxVector_93*: INNER_C_UNION_orxVector_88


##  *** Vector inlined functions ***
## * Sets vector XYZ values (also work for other coordinate system)
##  @param[in]   _pvVec                        Concerned vector
##  @param[in]   _fX                           First coordinate value
##  @param[in]   _fY                           Second coordinate value
##  @param[in]   _fZ                           Third coordinate value
##  @return      Vector
##

proc orxVector_Set*(pvVec: ptr orxVECTOR; fX: orxFLOAT; fY: orxFLOAT; fZ: orxFLOAT): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Sets all the vector coordinates with the given value
##  @param[in]   _pvVec                        Concerned vector
##  @param[in]   _fValue                       Value to set
##  @return      Vector
##

proc orxVector_SetAll*(pvVec: ptr orxVECTOR; fValue: orxFLOAT): ptr orxVECTOR {.cdecl.} =
  discard

## * Copies a vector onto another one
##  @param[in]   _pvDst                        Vector to copy to (destination)
##  @param[in]   _pvSrc                        Vector to copy from (source)
##  @return      Destination vector
##

proc orxVector_Copy*(pvDst: ptr orxVECTOR; pvSrc: ptr orxVECTOR): ptr orxVECTOR {.cdecl.} =
  discard

## * Adds vectors and stores result in a third one
##  @param[out]  _pvRes                        Vector where to store result (can be one of the two operands)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _pvOp2                        Second operand
##  @return      Resulting vector (Op1 + Op2)
##

proc orxVector_Add*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Substracts vectors and stores result in a third one
##  @param[out]  _pvRes                        Vector where to store result (can be one of the two operands)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _pvOp2                        Second operand
##  @return      Resulting vector (Op1 - Op2)
##

proc orxVector_Sub*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Multiplies a vector by an orxFLOAT and stores result in another one
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _fOp2                         Second operand
##  @return      Resulting vector
##

proc orxVector_Mulf*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; fOp2: orxFLOAT): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Multiplies a vector by another vector and stores result in a third one
##  @param[out]  _pvRes                        Vector where to store result (can be one of the two operands)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _pvOp2                        Second operand
##  @return      Resulting vector (Op1 * Op2)
##

proc orxVector_Mul*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Divides a vector by an orxFLOAT and stores result in another one
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _fOp2                         Second operand
##  @return      Resulting vector
##

proc orxVector_Divf*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; fOp2: orxFLOAT): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Divides a vector by another vector and stores result in a third one
##  @param[out]  _pvRes                        Vector where to store result (can be one of the two operands)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _pvOp2                        Second operand
##  @return      Resulting vector (Op1 / Op2)
##

proc orxVector_Div*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Lerps from one vector to another one using a coefficient
##  @param[out]  _pvRes                        Vector where to store result (can be one of the two operands)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _pvOp2                        Second operand
##  @param[in]   _fOp                          Lerp coefficient parameter
##  @return      Resulting vector
##

proc orxVector_Lerp*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR;
                    fOp: orxFLOAT): ptr orxVECTOR {.cdecl.} =
  discard

## * Gets minimum between two vectors
##  @param[out]  _pvRes                        Vector where to store result (can be one of the two operands)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _pvOp2                        Second operand
##  @return      Resulting vector MIN(Op1, Op2)
##

proc orxVector_Min*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Gets maximum between two vectors
##  @param[out]  _pvRes                        Vector where to store result (can be one of the two operands)
##  @param[in]   _pvOp1                        First operand
##  @param[in]   _pvOp2                        Second operand
##  @return      Resulting vector MAX(Op1, Op2)
##

proc orxVector_Max*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Clamps a vector between two others
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Vector to clamp
##  @param[in]   _pvMin                        Minimum boundary
##  @param[in]   _pvMax                        Maximum boundary
##  @return      Resulting vector CLAMP(Op, MIN, MAX)
##

proc orxVector_Clamp*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR; pvMin: ptr orxVECTOR;
                     pvMax: ptr orxVECTOR): ptr orxVECTOR {.cdecl.} =
  discard

## * Negates a vector and stores result in another one
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Vector to negates
##  @return      Resulting vector (-Op)
##

proc orxVector_Neg*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR): ptr orxVECTOR {.cdecl.} =
  discard

## * Gets reciprocal (1.0 /) vector and stores the result in another one
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Input value
##  @return      Resulting vector (1 / Op)
##

proc orxVector_Rec*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR): ptr orxVECTOR {.cdecl.} =
  discard

## * Gets floored vector and stores the result in another one
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Input value
##  @return      Resulting vector Floor(Op)
##

proc orxVector_Floor*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR): ptr orxVECTOR {.cdecl.} =
  discard

## * Gets rounded vector and stores the result in another one
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Input value
##  @return      Resulting vector Round(Op)
##

proc orxVector_Round*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR): ptr orxVECTOR {.cdecl.} =
  discard

## * Gets vector squared size
##  @param[in]   _pvOp                         Input vector
##  @return      Vector's squared size
##

proc orxVector_GetSquareSize*(pvOp: ptr orxVECTOR): orxFLOAT {.cdecl.} =
  discard

## * Gets vector size
##  @param[in]   _pvOp                         Input vector
##  @return      Vector's size
##

proc orxVector_GetSize*(pvOp: ptr orxVECTOR): orxFLOAT {.cdecl.} =
  discard

## * Gets squared distance between 2 positions
##  @param[in]   _pvOp1                        First position
##  @param[in]   _pvOp2                        Second position
##  @return      Squared distance
##

proc orxVector_GetSquareDistance*(pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): orxFLOAT {.
    cdecl.} =
  discard

## * Gets distance between 2 positions
##  @param[in]   _pvOp1                        First position
##  @param[in]   _pvOp2                        Second position
##  @return      Distance
##

proc orxVector_GetDistance*(pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): orxFLOAT {.
    cdecl.} =
  discard

## * Normalizes a vector
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Vector to normalize
##  @return      Normalized vector
##

proc orxVector_Normalize*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Rotates a 2D vector (along Z-axis)
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Vector to rotate
##  @param[in]   _fAngle                       Angle of rotation (radians)
##  @return      Rotated vector
##

proc orxVector_2DRotate*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR; fAngle: orxFLOAT): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Is vector null?
##  @param[in]   _pvOp                         Vector to test
##  @return      orxTRUE if vector's null, orxFALSE otherwise
##

proc orxVector_IsNull*(pvOp: ptr orxVECTOR): orxBOOL {.cdecl.} =
  discard

## * Are vectors equal?
##  @param[in]   _pvOp1                        First vector to compare
##  @param[in]   _pvOp2                        Second vector to compare
##  @return      orxTRUE if both vectors are equal, orxFALSE otherwise
##

proc orxVector_AreEqual*(pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): orxBOOL {.cdecl.} =
  discard

## * Transforms a cartesian vector into a spherical one
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Vector to transform
##  @return      Transformed vector
##

proc orxVector_FromCartesianToSpherical*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Transforms a spherical vector into a cartesian one
##  @param[out]  _pvRes                        Vector where to store result (can be the operand)
##  @param[in]   _pvOp                         Vector to transform
##  @return      Transformed vector
##

proc orxVector_FromSphericalToCartesian*(pvRes: ptr orxVECTOR; pvOp: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

## * Gets dot product of two vectors
##  @param[in]   _pvOp1                      First operand
##  @param[in]   _pvOp2                      Second operand
##  @return      Dot product
##

proc orxVector_Dot*(pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): orxFLOAT {.cdecl.} =
  discard

## * Gets 2D dot product of two vectors
##  @param[in]   _pvOp1                      First operand
##  @param[in]   _pvOp2                      Second operand
##  @return      2D dot product
##

proc orxVector_2DDot*(pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): orxFLOAT {.cdecl.} =
  discard

## * Gets cross product of two vectors
##  @param[out]  _pvRes                       Vector where to store result
##  @param[in]   _pvOp1                      First operand
##  @param[in]   _pvOp2                      Second operand
##  @return      Cross product orxVECTOR / orxNULL
##

proc orxVector_Cross*(pvRes: ptr orxVECTOR; pvOp1: ptr orxVECTOR; pvOp2: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl.} =
  discard

##  *** Vector functions ***
## * Computes an interpolated point on a cubic Bezier curve segment for a given parameter
##  @param[out]  _pvRes                      Vector where to store result
##  @param[in]   _pvPoint1                   First point for this curve segment
##  @param[in]   _pvPoint2                   First control point for this curve segment
##  @param[in]   _pvPoint3                   Second control point for this curve segment
##  @param[in]   _pvPoint4                   Last point for this curve segment
##  @param[in]   _fT                         Interpolation parameter in [0.0, 1.0]
##  @return      Interpolated point on the cubic Bezier curve segment
##

proc orxVector_Bezier*(pvRes: ptr orxVECTOR; pvPoint1: ptr orxVECTOR;
                      pvPoint2: ptr orxVECTOR; pvPoint3: ptr orxVECTOR;
                      pvPoint4: ptr orxVECTOR; fT: orxFLOAT): ptr orxVECTOR {.cdecl,
    importcpp: "orxVector_Bezier(@)", dynlib: "liborx.so".}
## * Computes an interpolated point on a Catmull-Rom curve segment for a given parameter
##  @param[out]  _pvRes                      Vector where to store result
##  @param[in]   _pvPoint1                   First control point for this curve segment
##  @param[in]   _pvPoint2                   Second control point for this curve segment
##  @param[in]   _pvPoint3                   Third control point for this curve segment
##  @param[in]   _pvPoint4                   Fourth control point for this curve segment
##  @param[in]   _fT                         Interpolation parameter in [0.0, 1.0]
##  @return      Interpolated point on the Catmull-Rom curve segment
##

proc orxVector_CatmullRom*(pvRes: ptr orxVECTOR; pvPoint1: ptr orxVECTOR;
                          pvPoint2: ptr orxVECTOR; pvPoint3: ptr orxVECTOR;
                          pvPoint4: ptr orxVECTOR; fT: orxFLOAT): ptr orxVECTOR {.
    cdecl, importcpp: "orxVector_CatmullRom(@)", dynlib: "liborx.so".}
##  *** Vector constants ***

var orxVECTOR_X* {.importcpp: "orxVECTOR_X", dynlib: "liborx.so".}: orxVECTOR

## *< X-Axis unit vector

var orxVECTOR_Y* {.importcpp: "orxVECTOR_Y", dynlib: "liborx.so".}: orxVECTOR

## *< Y-Axis unit vector

var orxVECTOR_Z* {.importcpp: "orxVECTOR_Z", dynlib: "liborx.so".}: orxVECTOR

## *< Z-Axis unit vector

var orxVECTOR_0* {.importcpp: "orxVECTOR_0", dynlib: "liborx.so".}: orxVECTOR

## *< Null vector

var orxVECTOR_1* {.importcpp: "orxVECTOR_1", dynlib: "liborx.so".}: orxVECTOR

## *< Vector filled with 1s

var orxVECTOR_RED* {.importcpp: "orxVECTOR_RED", dynlib: "liborx.so".}: orxVECTOR

## *< Red color vector

var orxVECTOR_GREEN* {.importcpp: "orxVECTOR_GREEN", dynlib: "liborx.so".}: orxVECTOR

## *< Green color vector

var orxVECTOR_BLUE* {.importcpp: "orxVECTOR_BLUE", dynlib: "liborx.so".}: orxVECTOR

## *< Blue color vector

var orxVECTOR_YELLOW* {.importcpp: "orxVECTOR_YELLOW", dynlib: "liborx.so".}: orxVECTOR

## *< Yellow color vector

var orxVECTOR_CYAN* {.importcpp: "orxVECTOR_CYAN", dynlib: "liborx.so".}: orxVECTOR

## *< Cyan color vector

var orxVECTOR_MAGENTA* {.importcpp: "orxVECTOR_MAGENTA", dynlib: "liborx.so".}: orxVECTOR

## *< Magenta color vector

var orxVECTOR_BLACK* {.importcpp: "orxVECTOR_BLACK", dynlib: "liborx.so".}: orxVECTOR

## *< Black color vector

var orxVECTOR_WHITE* {.importcpp: "orxVECTOR_WHITE", dynlib: "liborx.so".}: orxVECTOR

## *< White color vector

## * @}
