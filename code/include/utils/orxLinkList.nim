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
##  @file orxLinkList.h
##  @date 06/04/2005
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxLinkList
##
##  Linklist module
##  Module that handles linklists
##
##  @{
##
##  @section linklist Link List - How to
##  This module provides an easy and powerful interface for manipulating linked lists.
##
##  @subsection linklist_datadefine Data definition
##  Using this data structure as an example:
##  @code
##  typedef struct __orxFOO_t
##  {
##    orxU32 u32Data;        Data
##  } orxFOO;
##  @endcode
##
##  @subsection linklist_dataalloc Data without link
##  Creating a bank to allocate memory storage:
##  @code
##  orxBANK *pstBank = orxBank_Create(10, sizeof(orxFOO), orxBANK_KU32_FLAG_NONE, orxMEMORY_TYPE_MAIN);
##  @endcode
##  You can then instantiate it this way:
##  @code
##  orxFOO *pstNode = (orxFOO *)orxBank_Allocate(pstBank);
##  pstNode->u32Data = 205;
##  @endcode
##  Having this basic behavior, you can add list linking to it.
##  @subsection linklist_realalloc Linked list item definition
##  To do so, you need to include in your structure an orxLINKLIST_NODE member as *FIRST MEMBER*:
##  @code
##  typedef struct __orxFOO_t
##  {
##   orxLINKLIST_NODE stNode;
##   orxU32 u32Data;
##  } orxFOO;
##  @endcode
##  @subsection linklist_realuse Use of link list
##  Your data structure can now be linked in lists:
##  @code
##  orxLINKLIST stList;
##  orxLinkList_AddEnd(&stList, (orxLINKLIST_NODE *)pstNode);
##  @endcode
##  @note As the first member of your data structure is a linked list node, you can cast your structure to orxLINKLIST_NODE and reciprocally.
##

import
  orxInclude, debug/orxDebug

import
  base/orxType

type
  orxLINKLIST_NODE* {.bycopy.} = object
    pstNext*: ptr orxLINKLIST_NODE ## *< Next node pointer : 4/8
    pstPrevious*: ptr orxLINKLIST_NODE ## *< Previous node pointer : 8/16
    pstList*: ptr orxLINKLIST    ## *< Associated list pointer : 12/24
  orxLINKLIST* {.bycopy.} = object
    pstFirst*: ptr orxLINKLIST_NODE ## *< First node pointer : 4/8
    pstLast*: ptr orxLINKLIST_NODE ## *< Last node pointer : 8/16
    u32Count*: orxU32          ## *< Node count : 12/20
## * Cleans a linklist
##  @param[in]   _pstList                        Concerned list
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxLinkList_Clean*(pstList: ptr orxLINKLIST): orxSTATUS {.cdecl,
    importcpp: "orxLinkList_Clean(@)", dynlib: "liborx.so".}
## * Adds a node at the start of a list
##  @param[in]   _pstList                        Concerned list
##  @param[in]   _pstNode                        Node to add
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxLinkList_AddStart*(pstList: ptr orxLINKLIST; pstNode: ptr orxLINKLIST_NODE): orxSTATUS {.
    cdecl, importcpp: "orxLinkList_AddStart(@)", dynlib: "liborx.so".}
## * Adds a node at the end of a list
##  @param[in]   _pstList                        Concerned list
##  @param[in]   _pstNode                        Node to add
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxLinkList_AddEnd*(pstList: ptr orxLINKLIST; pstNode: ptr orxLINKLIST_NODE): orxSTATUS {.
    cdecl, importcpp: "orxLinkList_AddEnd(@)", dynlib: "liborx.so".}
## * Adds a node before another one
##  @param[in]   _pstRefNode                     Reference node (add before this one)
##  @param[in]   _pstNode                        Node to add
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxLinkList_AddBefore*(pstRefNode: ptr orxLINKLIST_NODE;
                           pstNode: ptr orxLINKLIST_NODE): orxSTATUS {.cdecl,
    importcpp: "orxLinkList_AddBefore(@)", dynlib: "liborx.so".}
## * Adds a node after another one
##  @param[in]   _pstRefNode                     Reference node (add after this one)
##  @param[in]   _pstNode                        Node to add
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxLinkList_AddAfter*(pstRefNode: ptr orxLINKLIST_NODE;
                          pstNode: ptr orxLINKLIST_NODE): orxSTATUS {.cdecl,
    importcpp: "orxLinkList_AddAfter(@)", dynlib: "liborx.so".}
## * Removes a node from its list
##  @param[in]   _pstNode                        Concerned node
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxLinkList_Remove*(pstNode: ptr orxLINKLIST_NODE): orxSTATUS {.cdecl,
    importcpp: "orxLinkList_Remove(@)", dynlib: "liborx.so".}
##  *** LinkList inlined accessors ***
## * Gets a node list
##  @param[in]   _pstNode                        Concerned node
##  @return orxLINKLIST / orxNULL
##

proc orxLinkList_GetList*(pstNode: ptr orxLINKLIST_NODE): ptr orxLINKLIST {.cdecl.} =
  discard

## * Gets previous node in list
##  @param[in]   _pstNode                        Concerned node
##  @return orxLINKLIST_NODE / orxNULL
##

proc orxLinkList_GetPrevious*(pstNode: ptr orxLINKLIST_NODE): ptr orxLINKLIST_NODE {.
    cdecl.} =
  discard

## * Gets next node in list
##  @param[in]   _pstNode                        Concerned node
##  @return orxLINKLIST_NODE / orxNULL
##

proc orxLinkList_GetNext*(pstNode: ptr orxLINKLIST_NODE): ptr orxLINKLIST_NODE {.cdecl.} =
  discard

## * Gets a list first node
##  @param[in]   _pstList                        Concerned list
##  @return orxLINKLIST_NODE / orxNULL
##

proc orxLinkList_GetFirst*(pstList: ptr orxLINKLIST): ptr orxLINKLIST_NODE {.cdecl.} =
  discard

## * Gets a list last node
##  @param[in]   _pstList                        Concerned list
##  @return orxLINKLIST_NODE / orxNULL
##

proc orxLinkList_GetLast*(pstList: ptr orxLINKLIST): ptr orxLINKLIST_NODE {.cdecl.} =
  discard

## * Gets a list count
##  @param[in]   _pstList                        Concerned list
##  @return Number of nodes in list
##

proc orxLinkList_GetCount*(pstList: ptr orxLINKLIST): orxU32 {.cdecl.} =
  discard

## * @}
