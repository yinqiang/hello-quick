@echo off

START /B %QUICK_COCOS2DX_ROOT%\simulator\bin\win32\LuaHostWin32.exe -workdir %~dp0 -file scripts/main.lua -size 960x640