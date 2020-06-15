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
##  @file orxString.h
##  @date 21/04/2005
##  @author bestel@arcallians.org
##
##  @todo
##  - Add autoindexing for ID generation
##
## *
##  @addtogroup orxString
##
##  String module
##  Module that handles strings
##
##  @{
##

import
  orxInclude, memory/orxMemory, math/orxVector

import
  base/orxType

when defined(MSVC):
  const
    strtoll* = strtoi64
    strtoull* = strtoui64
import
  debug/orxDebug

const
  orxSTRING_KC_VECTOR_START* = '('
  orxSTRING_KC_VECTOR_START_ALT* = '{'
  orxSTRING_KC_VECTOR_SEPARATOR* = ','
  orxSTRING_KC_VECTOR_END* = ')'
  orxSTRING_KC_VECTOR_END_ALT* = '}'

## * Defines
##

const
  orxSTRING_KU32_CRC_POLYNOMIAL* = 0xEDB88320

## * CRC Tables (slice-by-8)
##

var saau32CRCTable* {.importcpp: "saau32CRCTable", dynlib: "liborx.so".}: array[8,
    array[256, orxU32]]

##  *** String inlined functions ***
## * Skips all white spaces
##  @param[in] _zString        Concerned string
##  @return    Sub string located after all leading white spaces, including EOL characters
##

proc orxString_SkipWhiteSpaces*(zString: ptr orxCHAR): ptr orxCHAR {.cdecl.} =
  discard

## * Skips path
##  @param[in] _zString        Concerned string
##  @return    Sub string located after all non-terminal directory separators
##

proc orxString_SkipPath*(zString: ptr orxCHAR): ptr orxCHAR {.cdecl.} =
  discard

## * Returns the number of orxCHAR in the string (for non-ASCII UTF-8 string, it won't be the actual number of unicode characters)
##  @param[in] _zString                  String used for length computation
##  @return                              Length of the string (doesn't count final orxCHAR_NULL)
##

proc orxString_GetLength*(zString: ptr orxCHAR): orxU32 {.cdecl.} =
  discard

## * Tells if a character is ASCII from its ID
##  @param[in] _u32CharacterCodePoint    Concerned character code
##  @return                              orxTRUE is it's a non-extended ASCII character, orxFALSE otherwise
##

proc orxString_IsCharacterASCII*(u32CharacterCodePoint: orxU32): orxBOOL {.cdecl.} =
  discard

## * Tells if a character is alpha-numeric from its ID
##  @param[in] _u32CharacterCodePoint    Concerned character code
##  @return                              orxTRUE is it's a non-extended ASCII alpha-numerical character, orxFALSE otherwise
##

proc orxString_IsCharacterAlphaNumeric*(u32CharacterCodePoint: orxU32): orxBOOL {.
    cdecl.} =
  discard

## * Gets the UTF-8 encoding length of given character
##  @param[in] _u32CharacterCodePoint    Concerned character code
##  @return                              Encoding length in UTF-8 for given character if valid, orxU32_UNDEFINED otherwise
##

proc orxString_GetUTF8CharacterLength*(u32CharacterCodePoint: orxU32): orxU32 {.
    cdecl.} =
  discard

## * Prints a unicode character encoded with UTF-8 to an orxSTRING
##  @param[in] _zDstString               Destination string
##  @param[in] _u32Size                  Available size on the string
##  @param[in] _u32CharacterCodePoint    Unicode code point of the character to print
##  @return                              Length of the encoded UTF-8 character (1, 2, 3 or 4) if valid, orxU32_UNDEFINED otherwise
##

proc orxString_PrintUTF8Character*(zDstString: ptr orxCHAR; u32Size: orxU32;
                                  u32CharacterCodePoint: orxU32): orxU32 {.cdecl.} =
  discard

## * Returns the code of the first character of the UTF-8 string
##  @param[in] _zString                  Concerned string
##  @param[out] _pzRemaining             If non null, will contain the remaining string after the first UTF-8 character
##  @return                              Code of the first UTF-8 character of the string, orxU32_UNDEFINED if it's an invalid character
##

proc orxString_GetFirstCharacterCodePoint*(zString: ptr orxCHAR;
    pzRemaining: ptr ptr orxCHAR): orxU32 {.cdecl.} =
  discard

## * Returns the number of valid unicode characters (UTF-8) in the string (for ASCII string, it will be the same result as orxString_GetLength())
##  @param[in] _zString                  Concerned string
##  @return                              Number of valid unicode characters contained in the string, orxU32_UNDEFINED for an invalid UTF-8 string
##

proc orxString_GetCharacterCount*(zString: ptr orxCHAR): orxU32 {.cdecl.} =
  discard

## * Copies up to N characters from a string
##  @param[in] _zDstString       Destination string
##  @param[in] _zSrcString       Source string
##  @param[in] _u32CharNumber    Number of characters to copy
##  @return Copied string
##

proc orxString_NCopy*(zDstString: ptr orxCHAR; zSrcString: ptr orxCHAR;
                     u32CharNumber: orxU32): ptr orxCHAR {.cdecl.} =
  discard

## * Duplicate a string.
##  @param[in] _zSrcString  String to duplicate.
##  @return Duplicated string.
##

proc orxString_Duplicate*(zSrcString: ptr orxCHAR): ptr orxCHAR {.cdecl.} =
  discard

## * Deletes a string
##  @param[in] _zString                  String to delete
##

proc orxString_Delete*(zString: ptr orxCHAR): orxSTATUS {.cdecl.} =
  discard

## * Compare two strings, case sensitive. If the first one is smaller than the second it returns -1,
##  1 if the second one is bigger than the first, and 0 if they are equals
##  @param[in] _zString1    First String to compare
##  @param[in] _zString2    Second string to compare
##  @return -1, 0 or 1 as indicated in the description.
##

proc orxString_Compare*(zString1: ptr orxCHAR; zString2: ptr orxCHAR): orxS32 {.cdecl.} =
  discard

## * Compare N first character from two strings, case sensitive. If the first one is smaller
##  than the second it returns -1, 1 if the second one is bigger than the first
##  and 0 if they are equals.
##  @param[in] _zString1       First String to compare
##  @param[in] _zString2       Second string to compare
##  @param[in] _u32CharNumber  Number of character to compare
##  @return -1, 0 or 1 as indicated in the description.
##

proc orxString_NCompare*(zString1: ptr orxCHAR; zString2: ptr orxCHAR;
                        u32CharNumber: orxU32): orxS32 {.cdecl.} =
  discard

## * Compare two strings, case insensitive. If the first one is smaller than the second, it returns -1,
##  If the second one is bigger than the first, and 0 if they are equals
##  @param[in] _zString1    First String to compare
##  @param[in] _zString2    Second string to compare
##  @return -1, 0 or 1 as indicated in the description.
##

proc orxString_ICompare*(zString1: ptr orxCHAR; zString2: ptr orxCHAR): orxS32 {.cdecl.} =
  discard

## * Compare N first character from two strings, case insensitive. If the first one is smaller
##  than the second, it returns -1, If the second one is bigger than the first,
##  and 0 if they are equals.
##  @param[in] _zString1       First String to compare
##  @param[in] _zString2       Second string to compare
##  @param[in] _u32CharNumber  Number of character to compare
##  @return -1, 0 or 1 as indicated in the description.
##

proc orxString_NICompare*(zString1: ptr orxCHAR; zString2: ptr orxCHAR;
                         u32CharNumber: orxU32): orxS32 {.cdecl.} =
  discard

## * Extracts the base (2, 8, 10 or 16) from a literal number
##  @param[in]   _zString        String from which to extract the base
##  @param[out]  _pzRemaining    If non null, will contain the remaining literal number, right after the base prefix (0x, 0b or 0)
##  @return  Base or the numerical value, defaults to 10 (decimal) when no prefix is found or the literal value couldn't be identified
##

proc orxString_ExtractBase*(zString: ptr orxCHAR; pzRemaining: ptr ptr orxCHAR): orxU32 {.
    cdecl.} =
  discard

## * Converts a String to a signed int value using the given base
##  @param[in]   _zString        String To convert
##  @param[in]   _u32Base        Base of the read value (generally 10, but can be 16 to read hexa)
##  @param[out]  _ps32OutValue   Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToS32Base*(zString: ptr orxCHAR; u32Base: orxU32;
                         ps32OutValue: ptr orxS32; pzRemaining: ptr ptr orxCHAR): orxSTATUS {.
    cdecl.} =
  discard

## * Converts a String to a signed int value, guessing the base
##  @param[in]   _zString        String To convert
##  @param[out]  _ps32OutValue   Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToS32*(zString: ptr orxCHAR; ps32OutValue: ptr orxS32;
                     pzRemaining: ptr ptr orxCHAR): orxSTATUS {.cdecl.} =
  discard

## * Converts a String to an unsigned int value using the given base
##  @param[in]   _zString        String To convert
##  @param[in]   _u32Base        Base of the read value (generally 10, but can be 16 to read hexa)
##  @param[out]  _pu32OutValue   Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToU32Base*(zString: ptr orxCHAR; u32Base: orxU32;
                         pu32OutValue: ptr orxU32; pzRemaining: ptr ptr orxCHAR): orxSTATUS {.
    cdecl.} =
  discard

## * Converts a String to an unsigned int value, guessing the base
##  @param[in]   _zString        String To convert
##  @param[out]  _pu32OutValue   Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToU32*(zString: ptr orxCHAR; pu32OutValue: ptr orxU32;
                     pzRemaining: ptr ptr orxCHAR): orxSTATUS {.cdecl.} =
  discard

## * Converts a String to a signed int value using the given base
##  @param[in]   _zString        String To convert
##  @param[in]   _u32Base        Base of the read value (generally 10, but can be 16 to read hexa)
##  @param[out]  _ps64OutValue   Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToS64Base*(zString: ptr orxCHAR; u32Base: orxU32;
                         ps64OutValue: ptr orxS64; pzRemaining: ptr ptr orxCHAR): orxSTATUS {.
    cdecl.} =
  discard

## * Converts a String to a signed int value, guessing the base
##  @param[in]   _zString        String To convert
##  @param[out]  _ps64OutValue   Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToS64*(zString: ptr orxCHAR; ps64OutValue: ptr orxS64;
                     pzRemaining: ptr ptr orxCHAR): orxSTATUS {.cdecl.} =
  discard

## * Converts a String to an unsigned int value using the given base
##  @param[in]   _zString        String To convert
##  @param[in]   _u32Base        Base of the read value (generally 10, but can be 16 to read hexa)
##  @param[out]  _pu64OutValue   Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToU64Base*(zString: ptr orxCHAR; u32Base: orxU32;
                         pu64OutValue: ptr orxU64; pzRemaining: ptr ptr orxCHAR): orxSTATUS {.
    cdecl.} =
  discard

## * Converts a String to an unsigned int value, guessing the base
##  @param[in]   _zString        String To convert
##  @param[out]  _pu64OutValue   Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToU64*(zString: ptr orxCHAR; pu64OutValue: ptr orxU64;
                     pzRemaining: ptr ptr orxCHAR): orxSTATUS {.cdecl.} =
  discard

## * Convert a string to a value
##  @param[in]   _zString        String To convert
##  @param[out]  _pfOutValue     Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToFloat*(zString: ptr orxCHAR; pfOutValue: ptr orxFLOAT;
                       pzRemaining: ptr ptr orxCHAR): orxSTATUS {.cdecl.} =
  discard

## * Convert a string to a vector
##  @param[in]   _zString        String To convert
##  @param[out]  _pvOutValue     Converted value. N.B.: if only two components (x, y) are defined, the z component will be set to zero
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the number conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToVector*(zString: ptr orxCHAR; pvOutValue: ptr orxVECTOR;
                        pzRemaining: ptr ptr orxCHAR): orxSTATUS {.cdecl.} =
  discard

## * Convert a string to a boolean
##  @param[in]   _zString        String To convert
##  @param[out]  _pbOutValue     Converted value
##  @param[out]  _pzRemaining    If non null, will contain the remaining string after the boolean conversion
##  @return  orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_ToBool*(zString: ptr orxCHAR; pbOutValue: ptr orxBOOL;
                      pzRemaining: ptr ptr orxCHAR): orxSTATUS {.cdecl.} =
  discard

## * Lowercase a string
##  @param[in] _zString          String To convert
##  @return The converted string.
##

proc orxString_LowerCase*(zString: ptr orxCHAR): ptr orxCHAR {.cdecl.} =
  discard

## * Uppercase a string
##  @param[in] _zString          String To convert
##  @return The converted string.
##

proc orxString_UpperCase*(zString: ptr orxCHAR): ptr orxCHAR {.cdecl.} =
  discard

## * Returns the first occurrence of _zString2 in _zString1
##  @param[in] _zString1 String to analyze
##  @param[in] _zString2 String that must be inside _zString1
##  @return The pointer of the first occurrence of _zString2, or orxNULL if not found
##

proc orxString_SearchString*(zString1: ptr orxCHAR; zString2: ptr orxCHAR): ptr orxCHAR {.
    cdecl.} =
  discard

## * Returns the first occurrence of _cChar in _zString
##  @param[in] _zString String to analyze
##  @param[in] _cChar   The character to find
##  @return The pointer of the first occurrence of _cChar, or orxNULL if not found
##

proc orxString_SearchChar*(zString: ptr orxCHAR; cChar: orxCHAR): ptr orxCHAR {.cdecl.} =
  discard

## * Returns the first occurrence of _cChar in _zString
##  @param[in] _zString      String to analyze
##  @param[in] _cChar        The character to find
##  @param[in] _s32Position  Search begin position
##  @return The index of the next occurrence of requested character, starting at given position / -1 if not found
##

proc orxString_SearchCharIndex*(zString: ptr orxCHAR; cChar: orxCHAR;
                               s32Position: orxS32): orxS32 {.cdecl.} =
  discard

## * Prints a formated string to a memory buffer
##  @param[out] _zDstString  Destination string
##  @param[in]  _zSrcString  Source formated string
##  @return The number of written characters
##

proc orxString_Print*(zDstString: ptr orxCHAR; zSrcString: ptr orxCHAR): orxS32 {.
    varargs, cdecl.} =
  discard

## * Prints a formated string to a memory buffer using a max size
##  @param[out] _zDstString    Destination string
##  @param[in]  _zSrcString    Source formated string
##  @param[in]  _u32CharNumber Max number of character to print
##  @return The number of written characters
##

proc orxString_NPrint*(zDstString: ptr orxCHAR; u32CharNumber: orxU32;
                      zSrcString: ptr orxCHAR): orxS32 {.varargs, cdecl.} =
  discard

## * Gets the extension from a file name
##  @param[in]  _zFileName     Concerned file name
##  @return Extension if exists, orxSTRING_EMPTY otherwise
##

proc orxString_GetExtension*(zFileName: ptr orxCHAR): ptr orxCHAR {.cdecl.} =
  discard

##  *** String module functions ***
## * Structure module setup
##

proc orxString_Setup*() {.cdecl, importcpp: "orxString_Setup(@)", dynlib: "liborx.so".}
## * Initializess the structure module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxString_Init*(): orxSTATUS {.cdecl, importcpp: "orxString_Init(@)",
                                 dynlib: "liborx.so".}
## * Exits from the structure module
##

proc orxString_Exit*() {.cdecl, importcpp: "orxString_Exit(@)", dynlib: "liborx.so".}
## * Gets a string's ID (and stores the string internally to prevent duplication)
##  @param[in]   _zString        Concerned string
##  @return      String's ID
##

proc orxString_GetID*(zString: ptr orxCHAR): orxSTRINGID {.cdecl,
    importcpp: "orxString_GetID(@)", dynlib: "liborx.so".}
## * Gets a string from an ID (it should have already been stored internally with a call to orxString_GetID)
##  @param[in]   _u32ID          Concerned string ID
##  @return      orxSTRING if ID's found, orxSTRING_EMPTY otherwise
##

proc orxString_GetFromID*(u32ID: orxSTRINGID): ptr orxCHAR {.cdecl,
    importcpp: "orxString_GetFromID(@)", dynlib: "liborx.so".}
## * Stores a string internally: equivalent to an optimized call to orxString_GetFromID(orxString_GetID(_zString))
##  @param[in]   _zString        Concerned string
##  @return      Stored orxSTRING
##

proc orxString_Store*(zString: ptr orxCHAR): ptr orxCHAR {.cdecl,
    importcpp: "orxString_Store(@)", dynlib: "liborx.so".}
## * @}
