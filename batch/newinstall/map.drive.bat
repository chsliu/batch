REM @echo off

set user=%COMPUTERNAME%\%USERNAME%
set pass=goodview
set server=s6


REM net use H: /del
REM net use M: /del
REM net use N: /del
REM net use P: /del
REM net use R: /del
REM net use S: /del
REM net use T: /del
REM net use X: /del
REM net use Y: /del

for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if exist %%G:\nul (
	net use %%G: /del
  )
)


net use H: \\%server%\home %pass% /user:%user% /persistent:yes

net use I: \\%server%\網管區 %pass% /user:%user% /persistent:yes

net use M: \\%server%\MRP2004 %pass% /user:%user% /persistent:yes
net use N: \\%server%\ACCT2004 %pass% /user:%user% /persistent:yes

net use P: \\%server%\公共區 %pass% /user:%user% /persistent:yes
net use R: \\%server%\EPROM %pass% /user:%user% /persistent:yes

net use S: \\%server%\研發部 %pass% /user:%user% /persistent:yes
net use T: \\%server%\暫存區 %pass% /user:%user% /persistent:yes

net use X: \\%server%\MRP2004_NEW %pass% /user:%user% /persistent:yes
net use Y: \\%server%\ACCT2004_NEW %pass% /user:%user% /persistent:yes


