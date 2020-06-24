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
##  @file orxFile.h
##  @date 01/05/2005
##  @author bestel@arcallians.org
##
##  @todo
##
## *
##  @addtogroup orxFile
##
##  File / file system module
##  Module that handles file / file system access
##
##  @{
##

import
  orxInclude

import
  base/orxType

const
  orxFILE_KU32_FLAG_INFO_NORMAL* = 0x00000001
  orxFILE_KU32_FLAG_INFO_READONLY* = 0x00000002
  orxFILE_KU32_FLAG_INFO_HIDDEN* = 0x00000004
  orxFILE_KU32_FLAG_INFO_DIRECTORY* = 0x00000008
  orxFILE_KU32_FLAG_OPEN_READ* = 0x10000000
  orxFILE_KU32_FLAG_OPEN_WRITE* = 0x20000000
  orxFILE_KU32_FLAG_OPEN_APPEND* = 0x40000000
  orxFILE_KU32_FLAG_OPEN_BINARY* = 0x80000000

## * File info structure

type
  orxFILE_INFO* {.bycopy.} = object
    s64Size*: orxS64           ## *< File's size (in bytes)
    s64TimeStamp*: orxS64      ## *< Timestamp of the last modification
    u32Flags*: orxU32          ## *< File attributes (cf. list of available flags)
    hInternal*: orxHANDLE      ## *< Internal use handle
    zName*: array[256, orxCHAR] ## *< File's name
    zPattern*: array[256, orxCHAR] ## *< Search pattern
    zPath*: array[1024, orxCHAR] ## *< Directory's name where is stored the file
    zFullName*: array[1280, orxCHAR] ## *< Full file name


## * Internal File structure
##

type orxFILE* = object
## * File module setup

proc orxFile_Setup*() {.cdecl, importc: "orxFile_Setup", dynlib: "liborx.so".}
## * Inits the File Module
##

proc orxFile_Init*(): orxSTATUS {.cdecl, importc: "orxFile_Init", dynlib: "liborx.so".}
## * Exits from the File Module
##

proc orxFile_Exit*() {.cdecl, importc: "orxFile_Exit", dynlib: "liborx.so".}
## * Gets current user's home directory using linux separators (without trailing separator)
##  @param[in] _zSubPath                     Sub-path to append to the home directory, nil for none
##  @return Current user's home directory, use it immediately or copy it as will be modified by the next call to orxFile_GetHomeDirectory() or orxFile_GetApplicationSaveDirectory()
##

proc orxFile_GetHomeDirectory*(zSubPath: ptr orxCHAR): ptr orxCHAR {.cdecl,
    importc: "orxFile_GetHomeDirectory", dynlib: "liborx.so".}
## * Gets current user's application save directory using linux separators (without trailing separator)
##  @param[in] _zSubPath                     Sub-path to append to the application save directory, nil for none
##  @return Current user's application save directory, use it immediately or copy it as it will be modified by the next call to orxFile_GetHomeDirectory() or orxFile_GetApplicationSaveDirectory()
##

proc orxFile_GetApplicationSaveDirectory*(zSubPath: ptr orxCHAR): ptr orxCHAR {.cdecl,
    importc: "orxFile_GetApplicationSaveDirectory", dynlib: "liborx.so".}
## * Checks if a file/directory exists
##  @param[in] _zFileName           Concerned file/directory
##  @return orxFALSE if _zFileName doesn't exist, orxTRUE otherwise
##

proc orxFile_Exists*(zFileName: ptr orxCHAR): orxBOOL {.cdecl,
    importc: "orxFile_Exists", dynlib: "liborx.so".}
## * Starts a new file search: finds the first file/directory that will match to the given pattern (ex: /bin/foo*)
##  @param[in] _zSearchPattern      Pattern used for file/directory search
##  @param[out] _pstFileInfo        Information about the first file found
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFile_FindFirst*(zSearchPattern: ptr orxCHAR; pstFileInfo: ptr orxFILE_INFO): orxSTATUS {.
    cdecl, importc: "orxFile_FindFirst", dynlib: "liborx.so".}
## * Continues a file search: finds the next occurrence of a pattern, the search has to be started with orxFile_FindFirst
##  @param[in,out] _pstFileInfo      Information about the last found file/directory
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFile_FindNext*(pstFileInfo: ptr orxFILE_INFO): orxSTATUS {.cdecl,
    importc: "orxFile_FindNext", dynlib: "liborx.so".}
## * Closes a search (frees the memory allocated for this search)
##  @param[in] _pstFileInfo         Information returned during search
##

proc orxFile_FindClose*(pstFileInfo: ptr orxFILE_INFO) {.cdecl,
    importc: "orxFile_FindClose", dynlib: "liborx.so".}
## * Retrieves a file/directory information
##  @param[in] _zFileName            Concerned file/directory name
##  @param[out] _pstFileInfo         Information of the file/directory
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFile_GetInfo*(zFileName: ptr orxCHAR; pstFileInfo: ptr orxFILE_INFO): orxSTATUS {.
    cdecl, importc: "orxFile_GetInfo", dynlib: "liborx.so".}
## * Removes a file or an empty directory
##  @param[in] _zFileName            Concerned file / directory
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFile_Remove*(zFileName: ptr orxCHAR): orxSTATUS {.cdecl,
    importc: "orxFile_Remove", dynlib: "liborx.so".}
## * Makes a directory, works recursively if needed
##  @param[in] _zName                Name of the directory to make
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxFile_MakeDirectory*(zName: ptr orxCHAR): orxSTATUS {.cdecl,
    importc: "orxFile_MakeDirectory", dynlib: "liborx.so".}
## * Opens a file for later read or write operation
##  @param[in] _zFileName           Full file's path to open
##  @param[in] _u32OpenFlags        List of used flags when opened
##  @return a File pointer (or nil if an error has occurred)
##

proc orxFile_Open*(zFileName: ptr orxCHAR; u32OpenFlags: orxU32): ptr orxFILE {.cdecl,
    importc: "orxFile_Open", dynlib: "liborx.so".}
## * Reads data from a file
##  @param[out] _pReadData          Buffer that will contain read data
##  @param[in] _s64ElemSize         Size of 1 element
##  @param[in] _s64NbElem           Number of elements
##  @param[in] _pstFile             Pointer to the file descriptor
##  @return Returns the number of read elements (not bytes)
##

proc orxFile_Read*(pReadData: pointer; s64ElemSize: orxS64; s64NbElem: orxS64;
                  pstFile: ptr orxFILE): orxS64 {.cdecl, importc: "orxFile_Read",
    dynlib: "liborx.so".}
## * Writes data to a file
##  @param[in] _pDataToWrite        Buffer that contains the data to write
##  @param[in] _s64ElemSize         Size of 1 element
##  @param[in] _s64NbElem           Number of elements
##  @param[in] _pstFile             Pointer to the file descriptor
##  @return Returns the number of written elements (not bytes)
##

proc orxFile_Write*(pDataToWrite: pointer; s64ElemSize: orxS64; s64NbElem: orxS64;
                   pstFile: ptr orxFILE): orxS64 {.cdecl, importc: "orxFile_Write",
    dynlib: "liborx.so".}
## * Deletes a file
##  @param[in] _zFileName           Full file's path to delete
##  @return orxSTATUS_SUCCESS upon success, orxSTATUS_FAILURE otherwise
##

proc orxFile_Delete*(zFileName: ptr orxCHAR): orxSTATUS {.cdecl,
    importc: "orxFile_Delete", dynlib: "liborx.so".}
## * Seeks to a position in the given file
##  @param[in] _pstFile              Concerned file
##  @param[in] _s64Position          Position (from start) where to set the indicator
##  @param[in] _eWhence              Starting point for the offset computation (start, current position or end)
##  @return Absolute cursor position if successful, -1 otherwise
##

proc orxFile_Seek*(pstFile: ptr orxFILE; s64Position: orxS64;
                  eWhence: orxSEEK_OFFSET_WHENCE): orxS64 {.cdecl,
    importc: "orxFile_Seek", dynlib: "liborx.so".}
## * Tells the current position of the indicator in a file
##  @param[in] _pstFile              Concerned file
##  @return Returns the current position of the file indicator, -1 is invalid
##

proc orxFile_Tell*(pstFile: ptr orxFILE): orxS64 {.cdecl, importc: "orxFile_Tell",
    dynlib: "liborx.so".}
## * Retrieves a file's size
##  @param[in] _pstFile              Concerned file
##  @return Returns the length of the file, <= 0 if invalid
##

proc orxFile_GetSize*(pstFile: ptr orxFILE): orxS64 {.cdecl,
    importc: "orxFile_GetSize", dynlib: "liborx.so".}
## * Retrieves a file's time of last modification
##  @param[in] _pstFile              Concerned file
##  @return Returns the time of the last modification, in seconds, since epoch
##

proc orxFile_GetTime*(pstFile: ptr orxFILE): orxS64 {.cdecl,
    importc: "orxFile_GetTime", dynlib: "liborx.so".}
## * Prints a formatted string to a file
##  @param[in] _pstFile             Pointer to the file descriptor
##  @param[in] _zString             Formatted string
##  @return Returns the number of written characters
##

proc orxFile_Print*(pstFile: ptr orxFILE; zString: ptr orxCHAR): orxS32 {.varargs, cdecl,
    importc: "orxFile_Print", dynlib: "liborx.so".}
## * Closes an oppened file
##  @param[in] _pstFile             File's pointer to close
##  @return Returns the status of the operation
##

proc orxFile_Close*(pstFile: ptr orxFILE): orxSTATUS {.cdecl,
    importc: "orxFile_Close", dynlib: "liborx.so".}
## * @}
