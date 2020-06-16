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
##  @file orxPlugin_CoreDefine.h
##  @date 09/05/2005
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxPlugin
##
##  Header that regroups all core plugin defines.
##
##  @{
##

##
##  Includes all core plugin headers
##

import
  plugin/define/orxPlugin_Display, plugin/define/orxPlugin_Joystick,
  plugin/define/orxPlugin_Keyboard, plugin/define/orxPlugin_Mouse,
  plugin/define/orxPlugin_Physics, plugin/define/orxPlugin_Render,
  plugin/define/orxPlugin_SoundSystem

##
##  Defines all core plugin register function
##

proc registerFunction_DISPLAY*() {.cdecl, importc: "_registerFunction_DISPLAY",
                                 dynlib: "liborx.so".}
proc registerFunction_JOYSTICK*() {.cdecl, importc: "_registerFunction_JOYSTICK",
                                  dynlib: "liborx.so".}
proc registerFunction_KEYBOARD*() {.cdecl, importc: "_registerFunction_KEYBOARD",
                                  dynlib: "liborx.so".}
proc registerFunction_MOUSE*() {.cdecl, importc: "_registerFunction_MOUSE",
                               dynlib: "liborx.so".}
proc registerFunction_PHYSICS*() {.cdecl, importc: "_registerFunction_PHYSICS",
                                 dynlib: "liborx.so".}
proc registerFunction_RENDER*() {.cdecl, importc: "_registerFunction_RENDER",
                                dynlib: "liborx.so".}
proc registerFunction_SOUNDSYSTEM*() {.cdecl,
                                     importc: "_registerFunction_SOUNDSYSTEM",
                                     dynlib: "liborx.so".}
##
##  Inline core plugin registration function
##

proc orxPlugin_RegisterCorePlugins*() {.inline, cdecl.} =
  registerFunction_DISPLAY()
  registerFunction_JOYSTICK()
  registerFunction_KEYBOARD()
  registerFunction_MOUSE()
  registerFunction_PHYSICS()
  registerFunction_RENDER()
  registerFunction_SOUNDSYSTEM()

## * @}
