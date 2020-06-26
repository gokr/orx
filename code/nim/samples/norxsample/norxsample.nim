## This is a port of the trivial sample that ORX comes with.
## Things can be fixed and cleaned, but it runs!

import os

import norx, norx/[incl, clock, event, system, config, resource, input, viewport, obj]

proc Update(pstClockInfo: ptr orxCLOCK_INFO, pContext: pointer) =
  ## Update function, it has been registered to be called every tick of the core clock
  # Should we quit due to user pressing ESC?
  if (orxInput_IsActive("Quit").bool):
    # Send close event
    echo "User quitting"
    discard orxEvent_SendShort(orxEVENT_TYPE_SYSTEM, orxSYSTEM_EVENT_CLOSE.orxU32)

proc Init(): orxSTATUS =
  ## Init function, it is called when all orx's modules have been initialized
  orxLOG("Norx Sample starting")

  # Create the viewport
  var v = orxViewport_CreateFromConfig("MainViewport")
  if not v.isNil:
    echo "Viewport created"
  
  # Create the scene
  var s = orxObject_CreateFromConfig("Scene")
  if not s.isNil:
    echo "Scene created"

  # Register the Update function to the core clock
  let clock = orxClock_Get(orxCLOCK_KZ_CORE)
  if not clock.isNil:
    echo "Clock gotten"
  var status = orxClock_Register(clock, cast[orxCLOCK_FUNCTION](Update), nil, orxMODULE_ID_MAIN, orxCLOCK_PRIORITY_NORMAL)
  if status == orxSTATUS_SUCCESS:
    echo "Clock registered"

  # Done!
  return orxSTATUS_SUCCESS

proc Run(): orxSTATUS =
  ## Run function, it should not contain any game logic
  # Return orxSTATUS_FAILURE to instruct orx to quit
  return orxSTATUS_SUCCESS

proc Exit() =
  ## Exit function, it is called before exiting from orx
  echo "Exit called"

proc Bootstrap(): orxSTATUS =
  ## Bootstrap function, it is called before config is initialized, allowing for early resource storage definitions
  # Add a config storage to find the initial config file
  var dir = getCurrentDir()
  var status = orxResource_AddStorage(orxCONFIG_KZ_RESOURCE_GROUP, $dir & "/data/config", orxFALSE)
  if status == orxSTATUS_SUCCESS:
    echo "Added storage"
  # Return orxSTATUS_FAILURE to prevent orx from loading the default config file
  return orxSTATUS_SUCCESS

when isMainModule:
  # Set the bootstrap function to provide at least one resource storage before loading any config files
  var status = orxConfig_SetBootstrap(cast[orxCONFIG_BOOTSTRAP_FUNCTION](Bootstrap))
  if status == orxSTATUS_SUCCESS:
    echo "Bootstrap was set"

  # Hack to produce C style argc/argv to pass on
  var argc = paramCount()
  var nargv = newSeq[string](argc + 1)
  nargv[0] = getAppFilename()  # Better than paramStr(0)
  var x = 1
  while x <= argc:
    nargv[x] = paramStr(x)
    inc(x)
  var argv: cstringArray = nargv.allocCStringArray()
  inc(argc)

  # Execute our game
  orx_Execute(argc.orxU32, argv, cast[orxMODULE_INIT_FUNCTION](Init), cast[orxMODULE_RUN_FUNCTION](Run), cast[orxMODULE_EXIT_FUNCTION](Exit))

  # Done!
  quit(0)