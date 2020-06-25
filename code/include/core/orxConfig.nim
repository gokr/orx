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
##  @file orxConfig.h
##  @date 02/02/2008
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxConfig
##
##  Config module
##  Module that handles configuration files
##
##  @{
##

import
  orxInclude, math/orxVector

import
  base/orxType

## * Defines
##

const
  orxCONFIG_KZ_RESOURCE_GROUP* = "Config"

## * Event enum
##

type
  orxCONFIG_EVENT* {.size: sizeof(cint).} = enum
    orxCONFIG_EVENT_RELOAD_START = 0, ## *< Event sent when reloading config starts
    orxCONFIG_EVENT_RELOAD_STOP, ## *< Event sent when reloading config stops
    orxCONFIG_EVENT_NUMBER, orxCONFIG_EVENT_NONE = orxENUM_NONE


## * Config callback function type to use with save function

type
  orxCONFIG_SAVE_FUNCTION* = proc (zSectionName: cstring; zKeyName: cstring;
                                zFileName: cstring; bUseEncryption: orxBOOL): orxBOOL {.
      cdecl.}

## * Config callback function type to use with clear function

type
  orxCONFIG_CLEAR_FUNCTION* = proc (zSectionName: cstring; zKeyName: cstring): orxBOOL {.
      cdecl.}
  orxCONFIG_BOOTSTRAP_FUNCTION* = proc (): orxSTATUS {.cdecl.}

## * Config module setup
##

proc orxConfig_Setup*() {.cdecl, importc: "orxConfig_Setup", dynlib: "liborx.so".}
## * Initializes the Config Module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_Init*(): orxSTATUS {.cdecl, importc: "orxConfig_Init",
                                 dynlib: "liborx.so".}
## * Exits from the Config Module
##

proc orxConfig_Exit*() {.cdecl, importc: "orxConfig_Exit", dynlib: "liborx.so".}
## * Sets encryption key
##  @param[in] _zEncryptionKey  Encryption key to use, nil to clear
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetEncryptionKey*(zEncryptionKey: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_SetEncryptionKey", dynlib: "liborx.so".}
## * Gets encryption key
##  @return Current encryption key / orxSTRING_EMPTY
##

proc orxConfig_GetEncryptionKey*(): cstring {.cdecl,
    importc: "orxConfig_GetEncryptionKey", dynlib: "liborx.so".}
## * Sets config bootstrap function: this function will get called when the config menu is initialized, before any config file is loaded.
##   The only available APIs within the bootstrap function are those of orxConfig and its dependencies (orxMemory, orxString, orxFile, orxEvent, orxResource, ...)
##  @param[in] _pfnBootstrap     Bootstrap function that will get called at module init, before loading any config file.
##                                 If this function returns orxSTATUS_FAILURE, the default config file will be skipped, otherwise the regular load sequence will happen
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetBootstrap*(pfnBootstrap: orxCONFIG_BOOTSTRAP_FUNCTION): orxSTATUS {.
    cdecl, importc: "orxConfig_SetBootstrap", dynlib: "liborx.so".}
## * Sets config base name
##  @param[in] _zBaseName        Base name used for default config file
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetBaseName*(zBaseName: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_SetBaseName", dynlib: "liborx.so".}
## * Gets config main file name
##  @return Config main file name / orxSTRING_EMPTY
##

proc orxConfig_GetMainFileName*(): cstring {.cdecl,
    importc: "orxConfig_GetMainFileName", dynlib: "liborx.so".}
## * Loads config file from source
##  @param[in] _zFileName        File name
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_Load*(zFileName: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_Load", dynlib: "liborx.so".}
## * Loads config data from a memory buffer. NB: the buffer will be modified during processing!
##  @param[in] _acBuffer         Buffer to process, will be modified during processing
##  @param[in] _u32BufferSize    Size of the buffer
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_LoadFromMemory*(acBuffer: cstring; u32BufferSize: orxU32): orxSTATUS {.
    cdecl, importc: "orxConfig_LoadFromMemory", dynlib: "liborx.so".}
## * Reloads config files from history
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_ReloadHistory*(): orxSTATUS {.cdecl,
    importc: "orxConfig_ReloadHistory", dynlib: "liborx.so".}
## * Writes config to given file. Will overwrite any existing file, including all comments.
##  @param[in] _zFileName        File name, if null or empty the default file name will be used
##  @param[in] _bUseEncryption   Use file encryption to make it human non-readable?
##  @param[in] _pfnSaveCallback  Callback used to filter sections/keys to save. If null, all sections/keys will be saved
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_Save*(zFileName: cstring; bUseEncryption: orxBOOL;
                    pfnSaveCallback: orxCONFIG_SAVE_FUNCTION): orxSTATUS {.cdecl,
    importc: "orxConfig_Save", dynlib: "liborx.so".}
## * Copies a file with optional encryption
##  @param[in] _zDstFileName     Name of the destination file
##  @param[in] _zSrcFileName     Name of the source file
##  @param[in] _zEncryptionKey   Encryption key to use when writing destination file, nil for no encryption
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_CopyFile*(zDstFileName: cstring; zSrcFileName: cstring;
                        zEncryptionKey: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_CopyFile", dynlib: "liborx.so".}
## * Merges multiple files into a single one, with optional encryption
##  @param[in] _zDstFileName     Name of the destination file
##  @param[in] _azSrcFileName    List of the names of the source files
##  @param[in] _u32Number        Number of source file names
##  @param[in] _zEncryptionKey   Encryption key to use when writing destination file, nil for no encryption
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_MergeFiles*(zDstFileName: cstring;
                          azSrcFileName: cstringArray; u32Number: orxU32;
                          zEncryptionKey: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_MergeFiles", dynlib: "liborx.so".}
## * Selects current working section
##  @param[in] _zSectionName     Section name to select
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SelectSection*(zSectionName: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_SelectSection", dynlib: "liborx.so".}
## * Renames a section
##  @param[in] _zSectionName     Section to rename
##  @param[in] _zNewSectionName  New name for the section
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_RenameSection*(zSectionName: cstring;
                             zNewSectionName: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_RenameSection", dynlib: "liborx.so".}
## * Gets section origin (ie. the file where it was defined for the first time or orxSTRING_EMPTY if not defined via a file)
##  @param[in] _zSectionName     Concerned section name
##  @return orxSTRING if found, orxSTRING_EMPTY otherwise
##

proc orxConfig_GetOrigin*(zSectionName: cstring): cstring {.cdecl,
    importc: "orxConfig_GetOrigin", dynlib: "liborx.so".}
## * Gets section origin ID (ie. the file where it was defined for the first time or orxSTRING_EMPTY if not defined via a file)
##  @param[in] _zSectionName     Concerned section name
##  @return String ID if found, orxSTRINGID_UNDEFINED otherwise
##

proc orxConfig_GetOriginID*(zSectionName: cstring): orxSTRINGID {.cdecl,
    importc: "orxConfig_GetOriginID", dynlib: "liborx.so".}
## * Sets a section's parent
##  @param[in] _zSectionName     Concerned section, if the section doesn't exist, it will be created
##  @param[in] _zParentName      Parent section's name, if the section doesn't exist, it will be created, if nil is provided, the former parent will be erased, if orxSTRING_EMPTY is provided, "no default parent" will be enforced
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetParent*(zSectionName: cstring; zParentName: cstring): orxSTATUS {.
    cdecl, importc: "orxConfig_SetParent", dynlib: "liborx.so".}
## * Gets a section's parent
##  @param[in] _zSectionName     Concerned section
##  @return Section's parent name if set or orxSTRING_EMPTY if no parent has been forced, nil otherwise
##

proc orxConfig_GetParent*(zSectionName: cstring): cstring {.cdecl,
    importc: "orxConfig_GetParent", dynlib: "liborx.so".}
## * Sets default parent for all sections
##  @param[in] _zSectionName     Section name that will be used as an implicit default parent section for all config sections, if nil is provided, default parent will be removed
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetDefaultParent*(zSectionName: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_SetDefaultParent", dynlib: "liborx.so".}
## * Gets current working section
##  @return Current selected section
##

proc orxConfig_GetCurrentSection*(): cstring {.cdecl,
    importc: "orxConfig_GetCurrentSection", dynlib: "liborx.so".}
## * Pushes a section (storing the current one on section stack)
##  @param[in] _zSectionName     Section name to push
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_PushSection*(zSectionName: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_PushSection", dynlib: "liborx.so".}
## * Pops last section from section stack
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_PopSection*(): orxSTATUS {.cdecl, importc: "orxConfig_PopSection",
                                       dynlib: "liborx.so".}
## * Has section for the given section name?
##  @param[in] _zSectionName     Section name
##  @return orxTRUE / orxFALSE
##

proc orxConfig_HasSection*(zSectionName: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_HasSection", dynlib: "liborx.so".}
## * Protects/unprotects a section from deletion (content might still be changed or deleted, but the section itself will resist delete/clear calls)
##  @param[in] _zSectionName     Section name to protect
##  @param[in] _bProtect         orxTRUE for protecting the section, orxFALSE to remove the protection
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_ProtectSection*(zSectionName: cstring; bProtect: orxBOOL): orxSTATUS {.
    cdecl, importc: "orxConfig_ProtectSection", dynlib: "liborx.so".}
## * Gets section count
##  @return Section count
##

proc orxConfig_GetSectionCount*(): orxU32 {.cdecl,
    importc: "orxConfig_GetSectionCount", dynlib: "liborx.so".}
## * Gets section at the given index
##  @param[in] _u32SectionIndex  Index of the desired section
##  @return orxSTRING if exist, orxSTRING_EMPTY otherwise
##

proc orxConfig_GetSection*(u32SectionIndex: orxU32): cstring {.cdecl,
    importc: "orxConfig_GetSection", dynlib: "liborx.so".}
## * Clears all config info
##  @param[in] _pfnClearCallback Callback used to filter sections/keys to clear. If null, all sections/keys will be cleared
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_Clear*(pfnClearCallback: orxCONFIG_CLEAR_FUNCTION): orxSTATUS {.
    cdecl, importc: "orxConfig_Clear", dynlib: "liborx.so".}
## * Clears section
##  @param[in] _zSectionName     Section name to clear
##

proc orxConfig_ClearSection*(zSectionName: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_ClearSection", dynlib: "liborx.so".}
## * Clears a value from current selected section
##  @param[in] _zKey             Key name
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_ClearValue*(zKey: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_ClearValue", dynlib: "liborx.so".}
## * Is this value locally inherited from another one (ie. with a Value = @... syntax)?
##  @param[in] _zKey             Key name
##  @return orxTRUE / orxFALSE
##

proc orxConfig_IsLocallyInheritedValue*(zKey: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_IsLocallyInheritedValue", dynlib: "liborx.so".}
## * Is this value inherited from another one (either locally or at section level)?
##  @param[in] _zKey             Key name
##  @return orxTRUE / orxFALSE
##

proc orxConfig_IsInheritedValue*(zKey: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_IsInheritedValue", dynlib: "liborx.so".}
## * Is this value random? (ie. using '~' character, within or without a list)
##  @param[in] _zKey             Key name
##  @return orxTRUE / orxFALSE
##

proc orxConfig_IsRandomValue*(zKey: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_IsRandomValue", dynlib: "liborx.so".}
## * Is this value dynamic? (ie. random and/or a list or command)
##  @param[in] _zKey             Key name
##  @return orxTRUE / orxFALSE
##

proc orxConfig_IsDynamicValue*(zKey: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_IsDynamicValue", dynlib: "liborx.so".}
## * Is this a command value? (ie. lazily evaluated command: %...)
##  @param[in] _zKey             Key name
##  @return orxTRUE / orxFALSE
##

proc orxConfig_IsCommandValue*(zKey: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_IsCommandValue", dynlib: "liborx.so".}
## * Has specified value for the given key?
##  @param[in] _zKey             Key name
##  @return orxTRUE / orxFALSE
##

proc orxConfig_HasValue*(zKey: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_HasValue", dynlib: "liborx.so".}
## * Gets a value's source section (ie. the section where the value is explicitly defined), only considering section inheritance, not local one
##  @param[in] _zKey             Key name
##  @return Name of the section that explicitly contains the value, orxSTRING_EMPTY if not found
##

proc orxConfig_GetValueSource*(zKey: cstring): cstring {.cdecl,
    importc: "orxConfig_GetValueSource", dynlib: "liborx.so".}
## * Reads a signed integer value from config (will take a random value if a list is provided for this key)
##  @param[in] _zKey             Key name
##  @return The value
##

proc orxConfig_GetS32*(zKey: cstring): orxS32 {.cdecl,
    importc: "orxConfig_GetS32", dynlib: "liborx.so".}
## * Reads an unsigned integer value from config (will take a random value if a list is provided for this key)
##  @param[in] _zKey             Key name
##  @return The value
##

proc orxConfig_GetU32*(zKey: cstring): orxU32 {.cdecl,
    importc: "orxConfig_GetU32", dynlib: "liborx.so".}
## * Reads a signed integer value from config (will take a random value if a list is provided for this key)
##  @param[in] _zKey             Key name
##  @return The value
##

proc orxConfig_GetS64*(zKey: cstring): orxS64 {.cdecl,
    importc: "orxConfig_GetS64", dynlib: "liborx.so".}
## * Reads an unsigned integer value from config (will take a random value if a list is provided for this key)
##  @param[in] _zKey             Key name
##  @return The value
##

proc orxConfig_GetU64*(zKey: cstring): orxU64 {.cdecl,
    importc: "orxConfig_GetU64", dynlib: "liborx.so".}
## * Reads a float value from config (will take a random value if a list is provided for this key)
##  @param[in] _zKey             Key name
##  @return The value
##

proc orxConfig_GetFloat*(zKey: cstring): orxFLOAT {.cdecl,
    importc: "orxConfig_GetFloat", dynlib: "liborx.so".}
## * Reads a string value from config (will take a random value if a list is provided for this key)
##  @param[in] _zKey             Key name
##  @return The value
##

proc orxConfig_GetString*(zKey: cstring): cstring {.cdecl,
    importc: "orxConfig_GetString", dynlib: "liborx.so".}
## * Reads a boolean value from config (will take a random value if a list is provided for this key)
##  @param[in] _zKey             Key name
##  @return The value
##

proc orxConfig_GetBool*(zKey: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_GetBool", dynlib: "liborx.so".}
## * Reads a vector value from config (will take a random value if a list is provided for this key)
##  @param[in]   _zKey             Key name
##  @param[out]  _pvVector         Storage for vector value
##  @return The value
##

proc orxConfig_GetVector*(zKey: cstring; pvVector: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importc: "orxConfig_GetVector", dynlib: "liborx.so".}
## * Duplicates a raw value (string) from config
##  @param[in] _zKey             Key name
##  @return The value. If non-null, needs to be deleted by the caller with orxString_Delete()
##

proc orxConfig_DuplicateRawValue*(zKey: cstring): cstring {.cdecl,
    importc: "orxConfig_DuplicateRawValue", dynlib: "liborx.so".}
## * Writes a signed integer value to config
##  @param[in] _zKey             Key name
##  @param[in] _s32Value         Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetS32*(zKey: cstring; s32Value: orxS32): orxSTATUS {.cdecl,
    importc: "orxConfig_SetS32", dynlib: "liborx.so".}
## * Writes an unsigned integer value to config
##  @param[in] _zKey             Key name
##  @param[in] _u32Value         Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetU32*(zKey: cstring; u32Value: orxU32): orxSTATUS {.cdecl,
    importc: "orxConfig_SetU32", dynlib: "liborx.so".}
## * Writes a signed integer value to config
##  @param[in] _zKey             Key name
##  @param[in] _s64Value         Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetS64*(zKey: cstring; s64Value: orxS64): orxSTATUS {.cdecl,
    importc: "orxConfig_SetS64", dynlib: "liborx.so".}
## * Writes an unsigned integer value to config
##  @param[in] _zKey             Key name
##  @param[in] _u64Value         Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetU64*(zKey: cstring; u64Value: orxU64): orxSTATUS {.cdecl,
    importc: "orxConfig_SetU64", dynlib: "liborx.so".}
## * Writes a float value to config
##  @param[in] _zKey             Key name
##  @param[in] _fValue           Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetFloat*(zKey: cstring; fValue: orxFLOAT): orxSTATUS {.cdecl,
    importc: "orxConfig_SetFloat", dynlib: "liborx.so".}
## * Writes a string value to config
##  @param[in] _zKey             Key name
##  @param[in] _zValue           Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetString*(zKey: cstring; zValue: cstring): orxSTATUS {.cdecl,
    importc: "orxConfig_SetString", dynlib: "liborx.so".}
## * Writes a string value to config, in block mode
##  @param[in] _zKey             Key name
##  @param[in] _zValue           Value to write in block mode
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetStringBlock*(zKey: cstring; zValue: cstring): orxSTATUS {.
    cdecl, importc: "orxConfig_SetStringBlock", dynlib: "liborx.so".}
## * Writes a boolean value to config
##  @param[in] _zKey             Key name
##  @param[in] _bValue           Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetBool*(zKey: cstring; bValue: orxBOOL): orxSTATUS {.cdecl,
    importc: "orxConfig_SetBool", dynlib: "liborx.so".}
## * Writes a vector value to config
##  @param[in] _zKey             Key name
##  @param[in] _pvValue          Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetVector*(zKey: cstring; pvValue: ptr orxVECTOR): orxSTATUS {.cdecl,
    importc: "orxConfig_SetVector", dynlib: "liborx.so".}
## * Is value a list for the given key?
##  @param[in] _zKey             Key name
##  @return orxTRUE / orxFALSE
##

proc orxConfig_IsList*(zKey: cstring): orxBOOL {.cdecl,
    importc: "orxConfig_IsList", dynlib: "liborx.so".}
## * Gets list count for a given key
##  @param[in] _zKey             Key name
##  @return List count if it's a valid list, 0 otherwise
##

proc orxConfig_GetListCount*(zKey: cstring): orxS32 {.cdecl,
    importc: "orxConfig_GetListCount", dynlib: "liborx.so".}
## * Reads a signed integer value from config list
##  @param[in] _zKey             Key name
##  @param[in] _s32ListIndex     Index of desired item in list / -1 for random
##  @return The value
##

proc orxConfig_GetListS32*(zKey: cstring; s32ListIndex: orxS32): orxS32 {.cdecl,
    importc: "orxConfig_GetListS32", dynlib: "liborx.so".}
## * Reads an unsigned integer value from config list
##  @param[in] _zKey             Key name
##  @param[in] _s32ListIndex     Index of desired item in list / -1 for random
##  @return The value
##

proc orxConfig_GetListU32*(zKey: cstring; s32ListIndex: orxS32): orxU32 {.cdecl,
    importc: "orxConfig_GetListU32", dynlib: "liborx.so".}
## * Reads a signed integer value from config list
##  @param[in] _zKey             Key name
##  @param[in] _s32ListIndex     Index of desired item in list / -1 for random
##  @return The value
##

proc orxConfig_GetListS64*(zKey: cstring; s32ListIndex: orxS32): orxS64 {.cdecl,
    importc: "orxConfig_GetListS64", dynlib: "liborx.so".}
## * Reads an unsigned integer value from config list
##  @param[in] _zKey             Key name
##  @param[in] _s32ListIndex     Index of desired item in list / -1 for random
##  @return The value
##

proc orxConfig_GetListU64*(zKey: cstring; s32ListIndex: orxS32): orxU64 {.cdecl,
    importc: "orxConfig_GetListU64", dynlib: "liborx.so".}
## * Reads a float value from config list
##  @param[in] _zKey             Key name
##  @param[in] _s32ListIndex     Index of desired item in list / -1 for random
##  @return The value
##

proc orxConfig_GetListFloat*(zKey: cstring; s32ListIndex: orxS32): orxFLOAT {.
    cdecl, importc: "orxConfig_GetListFloat", dynlib: "liborx.so".}
## * Reads a string value from config list
##  @param[in] _zKey             Key name
##  @param[in] _s32ListIndex     Index of desired item in list / -1 for random
##  @return The value
##

proc orxConfig_GetListString*(zKey: cstring; s32ListIndex: orxS32): cstring {.
    cdecl, importc: "orxConfig_GetListString", dynlib: "liborx.so".}
## * Reads a boolean value from config list
##  @param[in] _zKey             Key name
##  @param[in] _s32ListIndex     Index of desired item in list / -1 for random
##  @return The value
##

proc orxConfig_GetListBool*(zKey: cstring; s32ListIndex: orxS32): orxBOOL {.cdecl,
    importc: "orxConfig_GetListBool", dynlib: "liborx.so".}
## * Reads a vector value from config list
##  @param[in]   _zKey             Key name
##  @param[in]   _s32ListIndex     Index of desired item in list / -1 for random
##  @param[out]  _pvVector         Storage for vector value
##  @return The value
##

proc orxConfig_GetListVector*(zKey: cstring; s32ListIndex: orxS32;
                             pvVector: ptr orxVECTOR): ptr orxVECTOR {.cdecl,
    importc: "orxConfig_GetListVector", dynlib: "liborx.so".}
## * Writes a list of string values to config
##  @param[in] _zKey             Key name
##  @param[in] _azValue          Values
##  @param[in] _u32Number        Number of values
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_SetListString*(zKey: cstring; azValue: cstringArray;
                             u32Number: orxU32): orxSTATUS {.cdecl,
    importc: "orxConfig_SetListString", dynlib: "liborx.so".}
## * Appends string values to a config list (will create a new entry if not already present)
##  @param[in] _zKey             Key name
##  @param[in] _azValue          Values
##  @param[in] _u32Number        Number of values
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxConfig_AppendListString*(zKey: cstring; azValue: cstringArray;
                                u32Number: orxU32): orxSTATUS {.cdecl,
    importc: "orxConfig_AppendListString", dynlib: "liborx.so".}
## * Gets key count of the current section
##  @return Key count of the current section if valid, 0 otherwise
##

proc orxConfig_GetKeyCount*(): orxU32 {.cdecl, importc: "orxConfig_GetKeyCount",
                                     dynlib: "liborx.so".}
## * Gets key for the current section at the given index
##  @param[in] _u32KeyIndex      Index of the desired key
##  @return orxSTRING if exist, orxSTRING_EMPTY otherwise
##

proc orxConfig_GetKey*(u32KeyIndex: orxU32): cstring {.cdecl,
    importc: "orxConfig_GetKey", dynlib: "liborx.so".}
## * @}
