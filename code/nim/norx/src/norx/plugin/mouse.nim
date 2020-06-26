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

import norx/typ

type
  orxPLUGIN_FUNCTION_BASE_ID_MOUSE* {.size: sizeof(cint).} = enum
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_INIT = 0,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_EXIT,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_SET_POSITION,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_GET_POSITION,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_IS_BUTTON_PRESSED,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_GET_MOVE_DELTA,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_GET_WHEEL_DELTA,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_SHOW_CURSOR,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_NUMBER,
    orxPLUGIN_FUNCTION_BASE_ID_MOUSE_NONE = orxENUM_NONE