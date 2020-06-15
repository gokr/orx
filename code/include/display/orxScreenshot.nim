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
##  @file orxScreenshot.h
##  @date 07/12/2003
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxScreenshot
##
##  Screenshot module
##  Module that captures screenshots
##
##  @{
##

import
  orxInclude

## * Misc
##

when defined(IOS):
  const
    orxSCREENSHOT_KZ_DEFAULT_DIRECTORY_NAME* = "../Documents"
    orxSCREENSHOT_KZ_DEFAULT_BASE_NAME* = "screenshot-"
    orxSCREENSHOT_KZ_DEFAULT_EXTENSION* = "png"
    orxSCREENSHOT_KU32_DEFAULT_DIGITS* = 4
elif defined(ANDROID):
  const
    orxSCREENSHOT_KZ_DEFAULT_DIRECTORY_NAME* = "."
    orxSCREENSHOT_KZ_DEFAULT_BASE_NAME* = "screenshot-"
    orxSCREENSHOT_KZ_DEFAULT_EXTENSION* = "png"
    orxSCREENSHOT_KU32_DEFAULT_DIGITS* = 4
else:
  const
    orxSCREENSHOT_KZ_DEFAULT_DIRECTORY_NAME* = "."
    orxSCREENSHOT_KZ_DEFAULT_BASE_NAME* = "screenshot-"
    orxSCREENSHOT_KZ_DEFAULT_EXTENSION* = "tga"
    orxSCREENSHOT_KU32_DEFAULT_DIGITS* = 4
## * Screenshot module setup
##

proc orxScreenshot_Setup*() {.cdecl, importcpp: "orxScreenshot_Setup(@)",
                            dynlib: "liborx.so".}
## * Inits the screenshot module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxScreenshot_Init*(): orxSTATUS {.cdecl, importcpp: "orxScreenshot_Init(@)",
                                     dynlib: "liborx.so".}
## * Exits from the screenshot module
##

proc orxScreenshot_Exit*() {.cdecl, importcpp: "orxScreenshot_Exit(@)",
                           dynlib: "liborx.so".}
## * Captures a screenshot
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxScreenshot_Capture*(): orxSTATUS {.cdecl,
                                        importcpp: "orxScreenshot_Capture(@)",
                                        dynlib: "liborx.so".}
## * @}
