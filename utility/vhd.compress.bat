
powershell -command "Mount-vhd -readonly -path %1"

powershell -command "Optimize-vhd -Mode Full -path %1"

powershell -command "Dismount-vhd -path %1"

