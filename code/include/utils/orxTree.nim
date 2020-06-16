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
##  @file orxTree.h
##  @date 06/04/2005
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxTree
##
##  Tree module
##  Module that handles trees
##
##  @{
##

import
  orxInclude, debug/orxDebug

import
  base/orxType

type
  orxTREE_NODE* {.bycopy.} = object
    pstParent*: ptr orxTREE_NODE ## *< Parent node pointer : 4/8
    pstChild*: ptr orxTREE_NODE  ## *< First child node pointer : 8/16
    pstSibling*: ptr orxTREE_NODE ## *< Next sibling node pointer : 12/24
    pstPrevious*: ptr orxTREE_NODE ## *< Previous sibling node pointer : 16/32
    pstTree*: ptr orxTREE        ## *< Associated tree pointer : 20/40
  orxTREE* {.bycopy.} = object
    pstRoot*: ptr orxTREE_NODE  ## *< Root node pointer : 4/8
    u32Count*: orxU32          ## *< Node count : 8/12
## * Cleans a tree
##  @param[in]   _pstTree                        Concerned tree
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTree_Clean*(pstTree: ptr orxTREE): orxSTATUS {.cdecl,
    importc: "orxTree_Clean", dynlib: "liborx.so".}
## * Adds a node at the root of a tree
##  @param[in]   _pstTree                        Concerned tree
##  @param[in]   _pstNode                        Node to add
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTree_AddRoot*(pstTree: ptr orxTREE; pstNode: ptr orxTREE_NODE): orxSTATUS {.
    cdecl, importc: "orxTree_AddRoot", dynlib: "liborx.so".}
## * Adds a node as a parent of another one
##  @param[in]   _pstRefNode                     Reference node (add as a parent of this one)
##  @param[in]   _pstNode                        Node to add
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTree_AddParent*(pstRefNode: ptr orxTREE_NODE; pstNode: ptr orxTREE_NODE): orxSTATUS {.
    cdecl, importc: "orxTree_AddParent", dynlib: "liborx.so".}
## * Adds a node as a sibling of another one
##  @param[in]   _pstRefNode                     Reference node (add as a sibling of this one)
##  @param[in]   _pstNode                        Node to add
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTree_AddSibling*(pstRefNode: ptr orxTREE_NODE; pstNode: ptr orxTREE_NODE): orxSTATUS {.
    cdecl, importc: "orxTree_AddSibling", dynlib: "liborx.so".}
## * Adds a node as a child of another one
##  @param[in]   _pstRefNode                     Reference node (add as a child of this one)
##  @param[in]   _pstNode                        Node to add
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTree_AddChild*(pstRefNode: ptr orxTREE_NODE; pstNode: ptr orxTREE_NODE): orxSTATUS {.
    cdecl, importc: "orxTree_AddChild", dynlib: "liborx.so".}
## * Moves a node as a child of another one of the same tree
##  @param[in]   _pstRefNode                     Reference node (move as a child of this one)
##  @param[in]   _pstNode                        Node to move
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTree_MoveAsChild*(pstRefNode: ptr orxTREE_NODE; pstNode: ptr orxTREE_NODE): orxSTATUS {.
    cdecl, importc: "orxTree_MoveAsChild", dynlib: "liborx.so".}
## * Removes a node from its tree
##  @param[in]   _pstNode                        Concerned node
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxTree_Remove*(pstNode: ptr orxTREE_NODE): orxSTATUS {.cdecl,
    importc: "orxTree_Remove", dynlib: "liborx.so".}
##  *** Tree inlined accessors ***
## * Gets a node tree
##  @param[in]   _pstNode                        Concerned node
##  @return orxTREE / orxNULL
##

proc orxTree_GetTree*(pstNode: ptr orxTREE_NODE): ptr orxTREE {.inline, cdecl.} =
  ##  Checks
  orxASSERT(pstNode != orxNULL)
  ##  Returns it
  return pstNode.pstTree

## * Gets parent node
##  @param[in]   _pstNode                        Concerned node
##  @return orxTREE_NODE / orxNULL
##

proc orxTree_GetParent*(pstNode: ptr orxTREE_NODE): ptr orxTREE_NODE {.inline, cdecl.} =
  ##  Checks
  orxASSERT(pstNode != orxNULL)
  ##  Returns it
  return if (pstNode.pstTree != orxNULL): pstNode.pstParent else: cast[ptr orxTREE_NODE](orxNULL)

## * Gets first child node
##  @param[in]   _pstNode                        Concerned node
##  @return orxTREE_NODE / orxNULL
##

proc orxTree_GetChild*(pstNode: ptr orxTREE_NODE): ptr orxTREE_NODE {.inline, cdecl.} =
  ##  Checks
  orxASSERT(pstNode != orxNULL)
  ##  Returns it
  return if (pstNode.pstTree != orxNULL): pstNode.pstChild else: cast[ptr orxTREE_NODE](orxNULL)

## * Gets (next) sibling node
##  @param[in]   _pstNode                        Concerned node
##  @return orxTREE_NODE / orxNULL
##

proc orxTree_GetSibling*(pstNode: ptr orxTREE_NODE): ptr orxTREE_NODE {.inline, cdecl.} =
  ##  Checks
  orxASSERT(pstNode != orxNULL)
  ##  Returns it
  return if (pstNode.pstTree != orxNULL): pstNode.pstSibling else: cast[ptr orxTREE_NODE](orxNULL)

## * Gets previous sibling node
##  @param[in]   _pstNode                        Concerned node
##  @return orxTREE_NODE / orxNULL
##

proc orxTree_GetPrevious*(pstNode: ptr orxTREE_NODE): ptr orxTREE_NODE {.inline, cdecl.} =
  ##  Checks
  orxASSERT(pstNode != orxNULL)
  ##  Returns it
  return if (pstNode.pstTree != orxNULL): pstNode.pstPrevious else: cast[ptr orxTREE_NODE](orxNULL)

## * Gets a tree root
##  @param[in]   _pstTree                        Concerned tree
##  @return orxTREE_NODE / orxNULL
##

proc orxTree_GetRoot*(pstTree: ptr orxTREE): ptr orxTREE_NODE {.inline, cdecl.} =
  ##  Checks
  orxASSERT(pstTree != orxNULL)
  ##  Returns it
  return pstTree.pstRoot

## * Gets a tree count
##  @param[in]   _pstTree                        Concerned tree
##  @return Number of nodes in tree
##

proc orxTree_GetCount*(pstTree: ptr orxTREE): orxU32 {.inline, cdecl.} =
  ##  Checks
  orxASSERT(pstTree != orxNULL)
  ##  Returns it
  return pstTree.u32Count

## * @}
