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
##  @file orx.h
##  @date 02/09/2005
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup Orx
##
##  Main orx include, execution convenience helpers, freely modifiable by users
##
##  @{
##

import
  orxInclude, orxKernel, orxUtils

when not defined(PLUGIN):
  ## **************************************************************************
  ##  Static variables                                                        *
  ## *************************************************************************
  ## * Should stop execution by default event handling?
  ##
  var sbStopByEvent* {.importcpp: "sbStopByEvent", dynlib: "liborx.so".}: orxBOOL
  ## **************************************************************************
  ##  Public functions                                                        *
  ## *************************************************************************
  ## * Orx default basic event handler
  ##  @param[in]   _pstEvent                     Sent event
  ##  @return      orxSTATUS_SUCCESS if handled / orxSTATUS_FAILURE otherwise
  ##
  proc orx_DefaultEventHandler*(pstEvent: ptr orxEVENT): orxSTATUS {.cdecl.} =
    discard

  ## * Default main setup (module dependencies)
  ##
  proc orx_MainSetup*() {.cdecl.} =
    discard

  when defined(IOS):
  else:
    when defined(ANDROID) or defined(ANDROID_NATIVE):
      import
        main/orxAndroid

      ## * Orx main execution function
      ##  @param[in]   _u32NbParams                  Main function parameters number (argc)
      ##  @param[in]   _azParams                     Main function parameter list (argv)
      ##  @param[in]   _pfnInit                      Main init function (should init all the main stuff and register the main event handler to override the default one)
      ##  @param[in]   _pfnRun                       Main run function (will be called once per frame, should return orxSTATUS_SUCCESS to continue processing)
      ##  @param[in]   _pfnExit                      Main exit function (should clean all the main stuff)
      ##
      proc orx_Execute*(u32NbParams: orxU32; azParams: ptr ptr orxCHAR;
                       pfnInit: orxMODULE_INIT_FUNCTION;
                       pfnRun: orxMODULE_RUN_FUNCTION;
                       pfnExit: orxMODULE_EXIT_FUNCTION) {.cdecl.} =
        discard

    else:
      ## * Orx main execution function
      ##  @param[in]   _u32NbParams                  Main function parameters number (argc)
      ##  @param[in]   _azParams                     Main function parameter list (argv)
      ##  @param[in]   _pfnInit                      Main init function (should init all the main stuff and register the main event handler to override the default one)
      ##  @param[in]   _pfnRun                       Main run function (will be called once per frame, should return orxSTATUS_SUCCESS to continue processing)
      ##  @param[in]   _pfnExit                      Main exit function (should clean all the main stuff)
      ##
      proc orx_Execute*(u32NbParams: orxU32; azParams: ptr ptr orxCHAR;
                       pfnInit: orxMODULE_INIT_FUNCTION;
                       pfnRun: orxMODULE_RUN_FUNCTION;
                       pfnExit: orxMODULE_EXIT_FUNCTION) {.cdecl.} =
        discard

## * @}
