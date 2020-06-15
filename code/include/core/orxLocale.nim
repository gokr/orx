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
##  @file orxLocale.h
##  @date 15/07/2009
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxLocale
##
##  Localization module
##  Module that handles localized strings
##
##  @{
##

import
  orxInclude

## * Event enum
##

type
  orxLOCALE_EVENT* {.size: sizeof(cint).} = enum
    orxLOCALE_EVENT_SELECT_LANGUAGE = 0, ## *< Event sent when selecting a language
    orxLOCALE_EVENT_SET_STRING, ## *< Event sent when setting a string
    orxLOCALE_EVENT_NUMBER, orxLOCALE_EVENT_NONE = orxENUM_NONE


## * Locale event payload
##

type
  orxLOCALE_EVENT_PAYLOAD* {.bycopy.} = object
    zLanguage*: ptr orxCHAR     ## *< Current language : 4
    zStringKey*: ptr orxCHAR    ## *< String key : 8
    zStringValue*: ptr orxCHAR  ## *< String value : 12


## * Locale module setup
##

proc orxLocale_Setup*() {.cdecl, importcpp: "orxLocale_Setup(@)", dynlib: "liborx.so".}
## * Initializes the Locale Module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxLocale_Init*(): orxSTATUS {.cdecl, importcpp: "orxLocale_Init(@)",
                                 dynlib: "liborx.so".}
## * Exits from the Locale Module
##

proc orxLocale_Exit*() {.cdecl, importcpp: "orxLocale_Exit(@)", dynlib: "liborx.so".}
## * Selects current working language
##  @param[in] _zLanguage        Language to select
##

proc orxLocale_SelectLanguage*(zLanguage: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxLocale_SelectLanguage(@)", dynlib: "liborx.so".}
## * Gets current language
##  @return Current selected language
##

proc orxLocale_GetCurrentLanguage*(): ptr orxCHAR {.cdecl,
    importcpp: "orxLocale_GetCurrentLanguage(@)", dynlib: "liborx.so".}
## * Has given language? (if not correctly defined, false will be returned)
##  @param[in] _zLanguage        Concerned language
##  @return orxTRUE / orxFALSE
##

proc orxLocale_HasLanguage*(zLanguage: ptr orxCHAR): orxBOOL {.cdecl,
    importcpp: "orxLocale_HasLanguage(@)", dynlib: "liborx.so".}
## * Gets language count
##  @return Number of languages defined
##

proc orxLocale_GetLanguageCount*(): orxU32 {.cdecl,
    importcpp: "orxLocale_GetLanguageCount(@)", dynlib: "liborx.so".}
## * Gets language at the given index
##  @param[in] _u32LanguageIndex Index of the desired language
##  @return orxSTRING if exist, orxSTRING_EMPTY otherwise
##

proc orxLocale_GetLanguage*(u32LanguageIndex: orxU32): ptr orxCHAR {.cdecl,
    importcpp: "orxLocale_GetLanguage(@)", dynlib: "liborx.so".}
## * Has string for the given key?
##  @param[in] _zKey             Key name
##  @return orxTRUE / orxFALSE
##

proc orxLocale_HasString*(zKey: ptr orxCHAR): orxBOOL {.cdecl,
    importcpp: "orxLocale_HasString(@)", dynlib: "liborx.so".}
## * Reads a string in the current language for the given key
##  @param[in] _zKey             Key name
##  @return The value
##

proc orxLocale_GetString*(zKey: ptr orxCHAR): ptr orxCHAR {.cdecl,
    importcpp: "orxLocale_GetString(@)", dynlib: "liborx.so".}
## * Writes a string in the current language for the given key
##  @param[in] _zKey             Key name
##  @param[in] _zValue           Value
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxLocale_SetString*(zKey: ptr orxCHAR; zValue: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxLocale_SetString(@)", dynlib: "liborx.so".}
## * Gets key count for the current language
##  @return Key count the current language if valid, 0 otherwise
##

proc orxLocale_GetKeyCount*(): orxU32 {.cdecl,
                                     importcpp: "orxLocale_GetKeyCount(@)",
                                     dynlib: "liborx.so".}
## * Gets key for the current language at the given index
##  @param[in] _u32KeyIndex      Index of the desired key
##  @return orxSTRING if exist, orxNULL otherwise
##

proc orxLocale_GetKey*(u32KeyIndex: orxU32): ptr orxCHAR {.cdecl,
    importcpp: "orxLocale_GetKey(@)", dynlib: "liborx.so".}
## * @}
