Param([string]$Path = $(Throw '-Path is required')) 
Echo "Attempting to Mount $Path" 
Mount-vhd -path $Path -readonly 
Echo "Attempting to compact $Path" 
Optimize-vhd -path $Path -Mode Full 
Echo "Attempting to dismount $Path" 
Dismount-vhd -path $Path

