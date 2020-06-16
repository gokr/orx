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
##  @file orxPlugin_SoundSystem.h
##  @date 14/11/2003
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxPlugin
##
##  Header that defines all IDs of the sound system plugin
##
##  @{
##

import
  plugin/define/orxPlugin_CoreID

import
  base/orxType

type
  orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM* {.size: sizeof(cint).} = enum
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_INIT = 0,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_EXIT,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_CREATE_SAMPLE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_LOAD_SAMPLE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_DELETE_SAMPLE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_SAMPLE_INFO,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_SAMPLE_DATA,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_CREATE_FROM_SAMPLE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_CREATE_STREAM,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_CREATE_STREAM_FROM_FILE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_DELETE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_PLAY,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_PAUSE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_STOP,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_START_RECORDING,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_STOP_RECORDING,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_HAS_RECORDING_SUPPORT,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_VOLUME,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_PITCH,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_TIME,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_POSITION,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_ATTENUATION,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_REFERENCE_DISTANCE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_LOOP,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_VOLUME,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_PITCH,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_TIME,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_POSITION,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_ATTENUATION,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_REFERENCE_DISTANCE,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_IS_LOOPING,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_DURATION,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_STATUS,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_GLOBAL_VOLUME,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_GLOBAL_VOLUME,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_SET_LISTENER_POSITION,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_GET_LISTENER_POSITION,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_NUMBER,
    orxPLUGIN_FUNCTION_BASE_ID_SOUNDSYSTEM_NONE = orxENUM_NONE


## * @}
