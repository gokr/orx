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
##  @file orxSoundSystem.h
##  @date 13/07/2008
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxSoundSystem
##
##  Sound system plugin module
##  Plugin module that handles sound system
##
##  @{
##

import
  orxInclude, math/orxVector, plugin/orxPluginCore

import
  base/orxType

## **************************************************************************
##  Structure declaration                                                   *
## *************************************************************************
## * Abstract sound structures
##

type orxSOUNDSYSTEM_SOUND* = object
type orxSOUNDSYSTEM_SAMPLE* = object
## * Sound system status enum
##

type
  orxSOUNDSYSTEM_STATUS* {.size: sizeof(cint).} = enum
    orxSOUNDSYSTEM_STATUS_PLAY = 0, orxSOUNDSYSTEM_STATUS_PAUSE,
    orxSOUNDSYSTEM_STATUS_STOP, orxSOUNDSYSTEM_STATUS_NUMBER,
    orxSOUNDSYSTEM_STATUS_NONE = orxENUM_NONE


## * Config defines
##

const
  orxSOUNDSYSTEM_KZ_CONFIG_SECTION* = "SoundSystem"
  orxSOUNDSYSTEM_KZ_CONFIG_RATIO* = "DimensionRatio"
  orxSOUNDSYSTEM_KZ_CONFIG_STREAM_BUFFER_SIZE* = "StreamBufferSize"
  orxSOUNDSYSTEM_KZ_CONFIG_STREAM_BUFFER_NUMBER* = "StreamBufferNumber"

## **************************************************************************
##  Functions directly implemented by orx core
## *************************************************************************
## * Sound system module setup
##

proc orxSoundSystem_Setup*() {.cdecl, importcpp: "orxSoundSystem_Setup(@)",
                             dynlib: "liborx.so".}
## **************************************************************************
##  Functions extended by plugins
## *************************************************************************
## * Inits the sound system module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_Init*(): orxSTATUS {.cdecl, importcpp: "orxSoundSystem_Init(@)",
                                      dynlib: "liborx.so".}
## * Exits from the sound system module
##

proc orxSoundSystem_Exit*() {.cdecl, importcpp: "orxSoundSystem_Exit(@)",
                            dynlib: "liborx.so".}
## * Creates an empty sample
##  @param[in]   _u32ChannelNumber                     Number of channels of the sample
##  @param[in]   _u32FrameNumber                       Number of frame of the sample (number of "samples" = number of frames * number of channels)
##  @param[in]   _u32SampleRate                        Sampling rate of the sample (ie. number of frames per second)
##  @return orxSOUNDSYSTEM_SAMPLE / orxNULL
##

proc orxSoundSystem_CreateSample*(u32ChannelNumber: orxU32; u32FrameNumber: orxU32;
                                 u32SampleRate: orxU32): ptr orxSOUNDSYSTEM_SAMPLE {.
    cdecl, importcpp: "orxSoundSystem_CreateSample(@)", dynlib: "liborx.so".}
## * Loads a sound sample from file (cannot be played directly)
##  @param[in]   _zFilename                            Name of the file to load as a sample (completely loaded in memory, useful for sound effects)
##  @return orxSOUNDSYSTEM_SAMPLE / orxNULL
##

proc orxSoundSystem_LoadSample*(zFilename: ptr orxCHAR): ptr orxSOUNDSYSTEM_SAMPLE {.
    cdecl, importcpp: "orxSoundSystem_LoadSample(@)", dynlib: "liborx.so".}
## * Deletes a sound sample
##  @param[in]   _pstSample                            Concerned sample
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_DeleteSample*(pstSample: ptr orxSOUNDSYSTEM_SAMPLE): orxSTATUS {.
    cdecl, importcpp: "orxSoundSystem_DeleteSample(@)", dynlib: "liborx.so".}
## * Gets sample info
##  @param[in]   _pstSample                            Concerned sample
##  @param[in]   _pu32ChannelNumber                    Number of channels of the sample
##  @param[in]   _pu32FrameNumber                      Number of frame of the sample (number of "samples" = number of frames * number of channels)
##  @param[in]   _pu32SampleRate                       Sampling rate of the sample (ie. number of frames per second)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_GetSampleInfo*(pstSample: ptr orxSOUNDSYSTEM_SAMPLE;
                                  pu32ChannelNumber: ptr orxU32;
                                  pu32FrameNumber: ptr orxU32;
                                  pu32SampleRate: ptr orxU32): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_GetSampleInfo(@)", dynlib: "liborx.so".}
## * Sets sample data
##  @param[in]   _pstSample                            Concerned sample
##  @param[in]   _as16Data                             Data to set
##  @param[in]   _u32SampleNumber                      Number of samples in the data array
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_SetSampleData*(pstSample: ptr orxSOUNDSYSTEM_SAMPLE;
                                  as16Data: ptr orxS16; u32SampleNumber: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxSoundSystem_SetSampleData(@)", dynlib: "liborx.so".}
## * Creates a sound from preloaded sample (can be played directly)
##  @param[in]   _pstSample                            Concerned sample
##  @return orxSOUNDSYSTEM_SOUND / orxNULL
##

proc orxSoundSystem_CreateFromSample*(pstSample: ptr orxSOUNDSYSTEM_SAMPLE): ptr orxSOUNDSYSTEM_SOUND {.
    cdecl, importcpp: "orxSoundSystem_CreateFromSample(@)", dynlib: "liborx.so".}
## * Creates an empty stream
##  @param[in]   _u32ChannelNumber                     Number of channels for the stream
##  @param[in]   _u32SampleRate                        Sampling rate of the stream (ie. number of frames per second)
##  @param[in]   _zReference                           Reference name used for streaming events (usually the corresponding config ID)
##  @return orxSOUNDSYSTEM_SOUND / orxNULL
##

proc orxSoundSystem_CreateStream*(u32ChannelNumber: orxU32; u32SampleRate: orxU32;
                                 zReference: ptr orxCHAR): ptr orxSOUNDSYSTEM_SOUND {.
    cdecl, importcpp: "orxSoundSystem_CreateStream(@)", dynlib: "liborx.so".}
## * Creates a streamed sound from file (can be played directly)
##  @param[in]   _zFilename                            Name of the file to load as a stream (won't be completely loaded in memory, useful for musics)
##  @param[in]   _zReference                           Reference name used for streaming events (usually the corresponding config ID)
##  @return orxSOUNDSYSTEM_SOUND / orxNULL
##

proc orxSoundSystem_CreateStreamFromFile*(zFilename: ptr orxCHAR;
    zReference: ptr orxCHAR): ptr orxSOUNDSYSTEM_SOUND {.cdecl,
    importcpp: "orxSoundSystem_CreateStreamFromFile(@)", dynlib: "liborx.so".}
## * Deletes a sound
##  @param[in]   _pstSound                             Concerned sound
##

proc orxSoundSystem_Delete*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_Delete(@)", dynlib: "liborx.so".}
## * Plays a sound
##  @param[in]   _pstSound                             Concerned sound
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSoundSystem_Play*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_Play(@)", dynlib: "liborx.so".}
## * Pauses a sound
##  @param[in]   _pstSound                             Concerned sound
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSoundSystem_Pause*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_Pause(@)", dynlib: "liborx.so".}
## * Stops a sound
##  @param[in]   _pstSound                             Concerned sound
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSoundSystem_Stop*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_Stop(@)", dynlib: "liborx.so".}
## * Starts recording
##  @param[in]   _zName                                Name for the recorded sound/file
##  @param[in]   _bWriteToFile                         Should write to file?
##  @param[in]   _u32SampleRate                        Sample rate, 0 for default rate (44100Hz)
##  @param[in]   _u32ChannelNumber                     Channel number, 0 for default mono channel
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_StartRecording*(zName: ptr orxCHAR; bWriteToFile: orxBOOL;
                                   u32SampleRate: orxU32; u32ChannelNumber: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxSoundSystem_StartRecording(@)", dynlib: "liborx.so".}
## * Stops recording
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_StopRecording*(): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_StopRecording(@)", dynlib: "liborx.so".}
## * Is recording possible on the current system?
##  @return orxTRUE / orxFALSE
##

proc orxSoundSystem_HasRecordingSupport*(): orxBOOL {.cdecl,
    importcpp: "orxSoundSystem_HasRecordingSupport(@)", dynlib: "liborx.so".}
## * Sets a sound volume
##  @param[in]   _pstSound                             Concerned sound
##  @param[in]   _fVolume                              Volume to set [0, 1]
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSoundSystem_SetVolume*(pstSound: ptr orxSOUNDSYSTEM_SOUND; fVolume: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxSoundSystem_SetVolume(@)", dynlib: "liborx.so".}
## * Sets a sound pitch
##  @param[in]   _pstSound                             Concerned sound
##  @param[in]   _fPitch                               Pitch to set
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSoundSystem_SetPitch*(pstSound: ptr orxSOUNDSYSTEM_SOUND; fPitch: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxSoundSystem_SetPitch(@)", dynlib: "liborx.so".}
## * Sets a sound time (ie. cursor/play position from beginning)
##  @param[in]   _pstSound                             Concerned sound
##  @param[in]   _fTime                                Time, in seconds
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSoundSystem_SetTime*(pstSound: ptr orxSOUNDSYSTEM_SOUND; fTime: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxSoundSystem_SetTime(@)", dynlib: "liborx.so".}
## * Sets a sound position
##  @param[in]   _pstSound                             Concerned sound
##  @param[in]   _pvPosition                           Position to set
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSoundSystem_SetPosition*(pstSound: ptr orxSOUNDSYSTEM_SOUND;
                                pvPosition: ptr orxVECTOR): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_SetPosition(@)", dynlib: "liborx.so".}
## * Sets a sound attenuation
##  @param[in] _pstSound                               Concerned Sound
##  @param[in] _fAttenuation                           Desired attenuation
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_SetAttenuation*(pstSound: ptr orxSOUNDSYSTEM_SOUND;
                                   fAttenuation: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_SetAttenuation(@)", dynlib: "liborx.so".}
## * Sets a sound reference distance
##  @param[in] _pstSound                               Concerned Sound
##  @param[in] _fDistance                              Within this distance, sound is perceived at its maximum volume
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_SetReferenceDistance*(pstSound: ptr orxSOUNDSYSTEM_SOUND;
    fDistance: orxFLOAT): orxSTATUS {.cdecl, importcpp: "orxSoundSystem_SetReferenceDistance(@)",
                                   dynlib: "liborx.so".}
## * Loops a sound
##  @param[in]   _pstSound                             Concerned sound
##  @param[in]   _bLoop                                Loop / no loop
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSoundSystem_Loop*(pstSound: ptr orxSOUNDSYSTEM_SOUND; bLoop: orxBOOL): orxSTATUS {.
    cdecl, importcpp: "orxSoundSystem_Loop(@)", dynlib: "liborx.so".}
## * Gets a sound volume
##  @param[in]   _pstSound                             Concerned sound
##  @return Sound's volume
##

proc orxSoundSystem_GetVolume*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxFLOAT {.cdecl,
    importcpp: "orxSoundSystem_GetVolume(@)", dynlib: "liborx.so".}
## * Gets a sound pitch
##  @param[in]   _pstSound                             Concerned sound
##  @return Sound's pitch
##

proc orxSoundSystem_GetPitch*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxFLOAT {.cdecl,
    importcpp: "orxSoundSystem_GetPitch(@)", dynlib: "liborx.so".}
## * Gets a sound's time (ie. cursor/play position from beginning)
##  @param[in]   _pstSound                             Concerned sound
##  @return Sound's time (cursor/play position), in seconds
##

proc orxSoundSystem_GetTime*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxFLOAT {.cdecl,
    importcpp: "orxSoundSystem_GetTime(@)", dynlib: "liborx.so".}
## * Gets a sound position
##  @param[in]   _pstSound                             Concerned sound
##  @param[out]  _pvPosition                           Position to get
##  @return Sound's position
##

proc orxSoundSystem_GetPosition*(pstSound: ptr orxSOUNDSYSTEM_SOUND;
                                pvPosition: ptr orxVECTOR): ptr orxVECTOR {.cdecl,
    importcpp: "orxSoundSystem_GetPosition(@)", dynlib: "liborx.so".}
## * Gets a sound attenuation
##  @param[in] _pstSound                               Concerned Sound
##  @return Sound's attenuation
##

proc orxSoundSystem_GetAttenuation*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxFLOAT {.
    cdecl, importcpp: "orxSoundSystem_GetAttenuation(@)", dynlib: "liborx.so".}
## * Gets a sound reference distance
##  @param[in] _pstSound                               Concerned Sound
##  @return Sound's reference distance
##

proc orxSoundSystem_GetReferenceDistance*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxFLOAT {.
    cdecl, importcpp: "orxSoundSystem_GetReferenceDistance(@)", dynlib: "liborx.so".}
## * Is sound looping?
##  @param[in]   _pstSound                             Concerned sound
##  @return orxTRUE if looping, orxFALSE otherwise
##

proc orxSoundSystem_IsLooping*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxBOOL {.cdecl,
    importcpp: "orxSoundSystem_IsLooping(@)", dynlib: "liborx.so".}
## * Gets a sound duration
##  @param[in]   _pstSound                             Concerned sound
##  @return Sound's duration (seconds)
##

proc orxSoundSystem_GetDuration*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxFLOAT {.
    cdecl, importcpp: "orxSoundSystem_GetDuration(@)", dynlib: "liborx.so".}
## * Gets a sound status (play/pause/stop)
##  @param[in]   _pstSound                             Concerned sound
##  @return orxSOUNDSYSTEM_STATUS
##

proc orxSoundSystem_GetStatus*(pstSound: ptr orxSOUNDSYSTEM_SOUND): orxSOUNDSYSTEM_STATUS {.
    cdecl, importcpp: "orxSoundSystem_GetStatus(@)", dynlib: "liborx.so".}
## * Sets global volume
##  @param[in] _fGlobalVolume                          Global volume to set
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_SetGlobalVolume*(fGlobalVolume: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxSoundSystem_SetGlobalVolume(@)", dynlib: "liborx.so".}
## * Gets global volume
##  @return Gobal volume
##

proc orxSoundSystem_GetGlobalVolume*(): orxFLOAT {.cdecl,
    importcpp: "orxSoundSystem_GetGlobalVolume(@)", dynlib: "liborx.so".}
## * Sets listener position
##  @param[in] _pvPosition                             Desired position
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSoundSystem_SetListenerPosition*(pvPosition: ptr orxVECTOR): orxSTATUS {.
    cdecl, importcpp: "orxSoundSystem_SetListenerPosition(@)", dynlib: "liborx.so".}
## * Gets listener position
##  @param[out] _pvPosition                            Listener's position
##  @return orxVECTOR / orxNULL
##

proc orxSoundSystem_GetListenerPosition*(pvPosition: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxSoundSystem_GetListenerPosition(@)", dynlib: "liborx.so".}
## * @}
