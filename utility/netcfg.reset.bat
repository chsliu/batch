netcfg -v -b ms_msclient
netcfg -v -b ms_server

pause

netcfg -v -u ms_msclient
netcfg -v -u ms_server

pause

REM netcfg -v -l %windir%\inf\netserv.inf -c s -i ms_server
REM netcfg -v -l %windir%\inf\netmscli.inf -c c -i ms_msclient


regsvr32 /s %windir%\inf\Netcfgx.dll
netcfg -v -l  %windir%\inf\netserv.inf -c s -i MS_Server
netcfg -v -winpe
