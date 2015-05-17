echo dumping to firewalldump.txt

netsh advfirewall firewall show rule name=all > firewalldump.txt
