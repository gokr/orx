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
##  @file orxSound.h
##  @date 13/07/2008
##  @author iarwain@orx-project.org
##
##  @todo
##
## *
##  @addtogroup orxSound
##
##  Sound module
##  Module that handles sound
##
##  @{
##

import
  orxInclude, sound/orxSoundSystem, math/orxVector

## * Misc defines
##

const
  orxSOUND_KZ_RESOURCE_GROUP* = "Sound"
  orxSOUND_KZ_MASTER_BUS* = "master"

## * Sound status enum
##

type
  orxSOUND_STATUS* {.size: sizeof(cint).} = enum
    orxSOUND_STATUS_PLAY = 0, orxSOUND_STATUS_PAUSE, orxSOUND_STATUS_STOP,
    orxSOUND_STATUS_NUMBER, orxSOUND_STATUS_NONE = orxENUM_NONE


## * Internal Sound structure
##

type
  orxSOUND* = SOUND_t

## * Event enum
##

type
  orxSOUND_EVENT* {.size: sizeof(cint).} = enum
    orxSOUND_EVENT_START = 0,   ## *< Event sent when a sound starts
    orxSOUND_EVENT_STOP,      ## *< Event sent when a sound stops
    orxSOUND_EVENT_ADD,       ## *< Event sent when a sound is added
    orxSOUND_EVENT_REMOVE,    ## *< Event sent when a sound is removed
    orxSOUND_EVENT_PACKET,    ## *< Event sent when a sound packet is streamed. IMPORTANT: this event can be sent from a worker thread, do not call any orx API when handling it
    orxSOUND_EVENT_RECORDING_START, ## *< Event sent when recording starts
    orxSOUND_EVENT_RECORDING_STOP, ## *< Event sent when recording stops
    orxSOUND_EVENT_RECORDING_PACKET, ## *< Event sent when a packet has been recorded
    orxSOUND_EVENT_NUMBER, orxSOUND_EVENT_NONE = orxENUM_NONE


## * Sound stream info
##

type
  orxSOUND_STREAM_INFO* {.bycopy.} = object
    u32SampleRate*: orxU32     ## *< The sample rate, e.g. 44100 Hertz : 4
    u32ChannelNumber*: orxU32  ## *< Number of channels, either mono (1) or stereo (2) : 8


## * Sound recording packet
##

type
  orxSOUND_STREAM_PACKET* {.bycopy.} = object
    u32SampleNumber*: orxU32   ## *< Number of samples contained in this packet : 4
    as16SampleList*: ptr orxS16 ## *< List of samples for this packet : 8
    bDiscard*: orxBOOL         ## *< Write/play the packet? : 12
    fTimeStamp*: orxFLOAT      ## *< Packet's timestamp : 16
    s32ID*: orxS32             ## *< Packet's ID : 20
    fTime*: orxFLOAT           ## *< Packet's time (cursor/play position): 24


## * Sound event payload
##

type
  INNER_C_STRUCT_orxSound_130* {.bycopy.} = object
    zSoundName*: ptr orxCHAR    ## *< Sound name : 4
    stInfo*: orxSOUND_STREAM_INFO ## *< Sound record info : 12
    stPacket*: orxSOUND_STREAM_PACKET ## *< Sound record packet : 32

  INNER_C_UNION_orxSound_126* {.bycopy.} = object {.union.}
    pstSound*: ptr orxSOUND     ## *< Sound reference : 4
    stStream*: INNER_C_STRUCT_orxSound_130

  orxSOUND_EVENT_PAYLOAD* {.bycopy.} = object
    ano_orxSound_134*: INNER_C_UNION_orxSound_126


## * Sound module setup
##

proc orxSound_Setup*() {.cdecl, importcpp: "orxSound_Setup(@)", dynlib: "liborx.so".}
## * Initializes the sound module
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_Init*(): orxSTATUS {.cdecl, importcpp: "orxSound_Init(@)",
                                dynlib: "liborx.so".}
## * Exits from the sound module
##

proc orxSound_Exit*() {.cdecl, importcpp: "orxSound_Exit(@)", dynlib: "liborx.so".}
## * Creates an empty sound
##  @return      Created orxSOUND / orxNULL
##

proc orxSound_Create*(): ptr orxSOUND {.cdecl, importcpp: "orxSound_Create(@)",
                                    dynlib: "liborx.so".}
## * Creates sound from config
##  @param[in]   _zConfigID    Config ID
##  @ return orxSOUND / orxNULL
##

proc orxSound_CreateFromConfig*(zConfigID: ptr orxCHAR): ptr orxSOUND {.cdecl,
    importcpp: "orxSound_CreateFromConfig(@)", dynlib: "liborx.so".}
## * Creates a sound with an empty stream (ie. you'll need to provide actual sound data for each packet sent to the sound card using the event system)
##  @param[in] _u32ChannelNumber Number of channels of the stream
##  @param[in] _u32SampleRate    Sampling rate of the stream (ie. number of frames per second)
##  @param[in] _zName            Name to associate with this sound
##  @return orxSOUND / orxNULL
##

proc orxSound_CreateWithEmptyStream*(u32ChannelNumber: orxU32;
                                    u32SampleRate: orxU32; zName: ptr orxCHAR): ptr orxSOUND {.
    cdecl, importcpp: "orxSound_CreateWithEmptyStream(@)", dynlib: "liborx.so".}
## * Deletes sound
##  @param[in] _pstSound       Concerned Sound
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_Delete*(pstSound: ptr orxSOUND): orxSTATUS {.cdecl,
    importcpp: "orxSound_Delete(@)", dynlib: "liborx.so".}
## * Clears cache (if any sound sample is still in active use, it'll remain in memory until not referenced anymore)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_ClearCache*(): orxSTATUS {.cdecl, importcpp: "orxSound_ClearCache(@)",
                                      dynlib: "liborx.so".}
## * Creates a sample
##  @param[in] _u32ChannelNumber Number of channels of the sample
##  @param[in] _u32FrameNumber   Number of frame of the sample (number of "samples" = number of frames * number of channels)
##  @param[in] _u32SampleRate    Sampling rate of the sample (ie. number of frames per second)
##  @param[in] _zName            Name to associate with the sample
##  @return orxSOUNDSYSTEM_SAMPLE / orxNULL
##

proc orxSound_CreateSample*(u32ChannelNumber: orxU32; u32FrameNumber: orxU32;
                           u32SampleRate: orxU32; zName: ptr orxCHAR): ptr orxSOUNDSYSTEM_SAMPLE {.
    cdecl, importcpp: "orxSound_CreateSample(@)", dynlib: "liborx.so".}
## * Gets a sample
##  @param[in] _zName            Sample's name
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_GetSample*(zName: ptr orxCHAR): ptr orxSOUNDSYSTEM_SAMPLE {.cdecl,
    importcpp: "orxSound_GetSample(@)", dynlib: "liborx.so".}
## * Deletes a sample
##  @param[in] _zName            Sample's name
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_DeleteSample*(zName: ptr orxCHAR): orxSTATUS {.cdecl,
    importcpp: "orxSound_DeleteSample(@)", dynlib: "liborx.so".}
## * Links a sample
##  @param[in]   _pstSound     Concerned sound
##  @param[in]   _zSampleName  Name of the sample to link (must already be loaded/created)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_LinkSample*(pstSound: ptr orxSOUND; zSampleName: ptr orxCHAR): orxSTATUS {.
    cdecl, importcpp: "orxSound_LinkSample(@)", dynlib: "liborx.so".}
## * Unlinks (and deletes if not used anymore) a sample
##  @param[in]   _pstSound     Concerned sound
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_UnlinkSample*(pstSound: ptr orxSOUND): orxSTATUS {.cdecl,
    importcpp: "orxSound_UnlinkSample(@)", dynlib: "liborx.so".}
## * Is a stream (ie. music)?
##  @param[in] _pstSound       Concerned Sound
##  @return orxTRUE / orxFALSE
##

proc orxSound_IsStream*(pstSound: ptr orxSOUND): orxBOOL {.cdecl,
    importcpp: "orxSound_IsStream(@)", dynlib: "liborx.so".}
## * Plays sound
##  @param[in] _pstSound       Concerned Sound
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_Play*(pstSound: ptr orxSOUND): orxSTATUS {.cdecl,
    importcpp: "orxSound_Play(@)", dynlib: "liborx.so".}
## * Pauses sound
##  @param[in] _pstSound       Concerned Sound
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_Pause*(pstSound: ptr orxSOUND): orxSTATUS {.cdecl,
    importcpp: "orxSound_Pause(@)", dynlib: "liborx.so".}
## * Stops sound
##  @param[in] _pstSound       Concerned Sound
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_Stop*(pstSound: ptr orxSOUND): orxSTATUS {.cdecl,
    importcpp: "orxSound_Stop(@)", dynlib: "liborx.so".}
## * Starts recording
##  @param[in] _zName             Name for the recorded sound/file
##  @param[in] _bWriteToFile      Should write to file?
##  @param[in] _u32SampleRate     Sample rate, 0 for default rate (44100Hz)
##  @param[in] _u32ChannelNumber  Channel number, 0 for default mono channel
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_StartRecording*(zName: ptr orxCHAR; bWriteToFile: orxBOOL;
                             u32SampleRate: orxU32; u32ChannelNumber: orxU32): orxSTATUS {.
    cdecl, importcpp: "orxSound_StartRecording(@)", dynlib: "liborx.so".}
## * Stops recording
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_StopRecording*(): orxSTATUS {.cdecl,
    importcpp: "orxSound_StopRecording(@)", dynlib: "liborx.so".}
## * Is recording possible on the current system?
##  @return orxTRUE / orxFALSE
##

proc orxSound_HasRecordingSupport*(): orxBOOL {.cdecl,
    importcpp: "orxSound_HasRecordingSupport(@)", dynlib: "liborx.so".}
## * Sets sound volume
##  @param[in] _pstSound       Concerned Sound
##  @param[in] _fVolume        Desired volume (0.0 - 1.0)
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetVolume*(pstSound: ptr orxSOUND; fVolume: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxSound_SetVolume(@)", dynlib: "liborx.so".}
## * Sets sound pitch
##  @param[in] _pstSound       Concerned Sound
##  @param[in] _fPitch         Desired pitch
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetPitch*(pstSound: ptr orxSOUND; fPitch: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxSound_SetPitch(@)", dynlib: "liborx.so".}
## * Sets a sound time (ie. cursor/play position from beginning)
##  @param[in]   _pstSound                             Concerned sound
##  @param[in]   _fTime                                Time, in seconds
##  @return orxSTATUS_SUCCESS / orxSTATSUS_FAILURE
##

proc orxSound_SetTime*(pstSound: ptr orxSOUND; fTime: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxSound_SetTime(@)", dynlib: "liborx.so".}
## * Sets sound position
##  @param[in] _pstSound       Concerned Sound
##  @param[in] _pvPosition     Desired position
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetPosition*(pstSound: ptr orxSOUND; pvPosition: ptr orxVECTOR): orxSTATUS {.
    cdecl, importcpp: "orxSound_SetPosition(@)", dynlib: "liborx.so".}
## * Sets sound attenuation
##  @param[in] _pstSound       Concerned Sound
##  @param[in] _fAttenuation   Desired attenuation
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetAttenuation*(pstSound: ptr orxSOUND; fAttenuation: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxSound_SetAttenuation(@)", dynlib: "liborx.so".}
## * Sets sound reference distance
##  @param[in] _pstSound       Concerned Sound
##  @param[in] _fDistance      Within this distance, sound is perceived at its maximum volume
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetReferenceDistance*(pstSound: ptr orxSOUND; fDistance: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxSound_SetReferenceDistance(@)", dynlib: "liborx.so".}
## * Loops sound
##  @param[in] _pstSound       Concerned Sound
##  @param[in] _bLoop          orxTRUE / orxFALSE
##  @return orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_Loop*(pstSound: ptr orxSOUND; bLoop: orxBOOL): orxSTATUS {.cdecl,
    importcpp: "orxSound_Loop(@)", dynlib: "liborx.so".}
## * Gets sound volume
##  @param[in] _pstSound       Concerned Sound
##  @return orxFLOAT
##

proc orxSound_GetVolume*(pstSound: ptr orxSOUND): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetVolume(@)", dynlib: "liborx.so".}
## * Gets sound pitch
##  @param[in] _pstSound       Concerned Sound
##  @return orxFLOAT
##

proc orxSound_GetPitch*(pstSound: ptr orxSOUND): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetPitch(@)", dynlib: "liborx.so".}
## * Gets a sound's time (ie. cursor/play position from beginning)
##  @param[in]   _pstSound                             Concerned sound
##  @return Sound's time (cursor/play position), in seconds
##

proc orxSound_GetTime*(pstSound: ptr orxSOUND): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetTime(@)", dynlib: "liborx.so".}
## * Gets sound position
##  @param[in]  _pstSound      Concerned Sound
##  @param[out] _pvPosition    Sound's position
##  @return orxVECTOR / orxNULL
##

proc orxSound_GetPosition*(pstSound: ptr orxSOUND; pvPosition: ptr orxVECTOR): ptr orxVECTOR {.
    cdecl, importcpp: "orxSound_GetPosition(@)", dynlib: "liborx.so".}
## * Gets sound attenuation
##  @param[in] _pstSound       Concerned Sound
##  @return orxFLOAT
##

proc orxSound_GetAttenuation*(pstSound: ptr orxSOUND): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetAttenuation(@)", dynlib: "liborx.so".}
## * Gets sound reference distance
##  @param[in] _pstSound       Concerned Sound
##  @return orxFLOAT
##

proc orxSound_GetReferenceDistance*(pstSound: ptr orxSOUND): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetReferenceDistance(@)", dynlib: "liborx.so".}
## * Is sound looping?
##  @param[in] _pstSound       Concerned Sound
##  @return orxTRUE / orxFALSE
##

proc orxSound_IsLooping*(pstSound: ptr orxSOUND): orxBOOL {.cdecl,
    importcpp: "orxSound_IsLooping(@)", dynlib: "liborx.so".}
## * Gets sound duration
##  @param[in] _pstSound       Concerned Sound
##  @return orxFLOAT
##

proc orxSound_GetDuration*(pstSound: ptr orxSOUND): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetDuration(@)", dynlib: "liborx.so".}
## * Gets sound status
##  @param[in] _pstSound       Concerned Sound
##  @return orxSOUND_STATUS
##

proc orxSound_GetStatus*(pstSound: ptr orxSOUND): orxSOUND_STATUS {.cdecl,
    importcpp: "orxSound_GetStatus(@)", dynlib: "liborx.so".}
## * Gets sound config name
##  @param[in]   _pstSound     Concerned sound
##  @return      orxSTRING / orxSTRING_EMPTY
##

proc orxSound_GetName*(pstSound: ptr orxSOUND): ptr orxCHAR {.cdecl,
    importcpp: "orxSound_GetName(@)", dynlib: "liborx.so".}
## * Gets master bus ID
##  @return      Master bus ID
##

proc orxSound_GetMasterBusID*(): orxSTRINGID {.cdecl,
    importcpp: "orxSound_GetMasterBusID(@)", dynlib: "liborx.so".}
## * Gets sound's bus ID
##  @param[in]   _pstSound     Concerned sound
##  @return      Sound's bus ID
##

proc orxSound_GetBusID*(pstSound: ptr orxSOUND): orxSTRINGID {.cdecl,
    importcpp: "orxSound_GetBusID(@)", dynlib: "liborx.so".}
## * Sets sound's bus ID
##  @param[in]   _pstSound     Concerned sound
##  @param[in]   _stBusID      Bus ID to set
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetBusID*(pstSound: ptr orxSOUND; stBusID: orxSTRINGID): orxSTATUS {.
    cdecl, importcpp: "orxSound_SetBusID(@)", dynlib: "liborx.so".}
## * Gets next sound in bus
##  @param[in]   _pstSound     Concerned sound, orxNULL to get the first one
##  @param[in]   _stBusID      Bus ID to consider, orxSTRINGID_UNDEFINED for all
##  @return      orxSOUND / orxNULL
##

proc orxSound_GetNext*(pstSound: ptr orxSOUND; stBusID: orxSTRINGID): ptr orxSOUND {.
    cdecl, importcpp: "orxSound_GetNext(@)", dynlib: "liborx.so".}
## * Gets bus parent
##  @param[in]   _stBusID      Concerned bus ID
##  @return      Parent bus ID / orxSTRINGID_UNDEFINED
##

proc orxSound_GetBusParent*(stBusID: orxSTRINGID): orxSTRINGID {.cdecl,
    importcpp: "orxSound_GetBusParent(@)", dynlib: "liborx.so".}
## * Gets bus child
##  @param[in]   _stBusID      Concerned bus ID
##  @return      Child bus ID / orxSTRINGID_UNDEFINED
##

proc orxSound_GetBusChild*(stBusID: orxSTRINGID): orxSTRINGID {.cdecl,
    importcpp: "orxSound_GetBusChild(@)", dynlib: "liborx.so".}
## * Gets bus sibling
##  @param[in]   _stBusID      Concerned bus ID
##  @return      Sibling bus ID / orxSTRINGID_UNDEFINED
##

proc orxSound_GetBusSibling*(stBusID: orxSTRINGID): orxSTRINGID {.cdecl,
    importcpp: "orxSound_GetBusSibling(@)", dynlib: "liborx.so".}
## * Sets a bus parent
##  @param[in]   _stBusID      Concerned bus ID, will create it if not already existing
##  @param[in]   _stParentBusID  ID of the bus to use as parent, will create it if not already existing
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetBusParent*(stBusID: orxSTRINGID; stParentBusID: orxSTRINGID): orxSTATUS {.
    cdecl, importcpp: "orxSound_SetBusParent(@)", dynlib: "liborx.so".}
## * Gets bus volume (local, ie. unaffected by the whole bus hierarchy)
##  @param[in]   _stBusID      Concerned bus ID
##  @return      orxFLOAT
##

proc orxSound_GetBusVolume*(stBusID: orxSTRINGID): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetBusVolume(@)", dynlib: "liborx.so".}
## * Gets bus pitch (local, ie. unaffected by the whole bus hierarchy)
##  @param[in]   _stBusID      Concerned bus ID
##  @return      orxFLOAT
##

proc orxSound_GetBusPitch*(stBusID: orxSTRINGID): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetBusPitch(@)", dynlib: "liborx.so".}
## * Sets bus volume
##  @param[in]   _stBusID      Concerned bus ID, will create it if not already existing
##  @param[in]   _fVolume      Desired volume (0.0 - 1.0)
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetBusVolume*(stBusID: orxSTRINGID; fVolume: orxFLOAT): orxSTATUS {.
    cdecl, importcpp: "orxSound_SetBusVolume(@)", dynlib: "liborx.so".}
## * Sets bus pitch
##  @param[in]   _stBusID      Concerned bus ID, will create it if not already existing
##  @param[in]   _fPitch       Desired pitch
##  @return      orxSTATUS_SUCCESS / orxSTATUS_FAILURE
##

proc orxSound_SetBusPitch*(stBusID: orxSTRINGID; fPitch: orxFLOAT): orxSTATUS {.cdecl,
    importcpp: "orxSound_SetBusPitch(@)", dynlib: "liborx.so".}
## * Gets bus global volume, ie. taking into account the whole bus hierarchy
##  @param[in]   _stBusID      Concerned bus ID
##  @return      orxFLOAT
##

proc orxSound_GetBusGlobalVolume*(stBusID: orxSTRINGID): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetBusGlobalVolume(@)", dynlib: "liborx.so".}
## * Gets bus global pitch, ie. taking into account the whole bus hierarchy
##  @param[in]   _stBusID      Concerned bus ID
##  @return      orxFLOAT
##

proc orxSound_GetBusGlobalPitch*(stBusID: orxSTRINGID): orxFLOAT {.cdecl,
    importcpp: "orxSound_GetBusGlobalPitch(@)", dynlib: "liborx.so".}
## * @}
