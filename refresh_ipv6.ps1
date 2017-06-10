Disable-NetAdapterBinding -InterfaceAlias "eth0" -ComponentID ms_tcpip6
Enable-NetAdapterBinding -InterfaceAlias "eth0" -ComponentID ms_tcpip6
pause