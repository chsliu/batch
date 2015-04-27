REM services
REM Windows Time Service turn on

w32tm /config /update /manualpeerlist:"time.stdtime.gov.tw clock.stdtime.gov.tw tick.stdtime.gov.tw tock.stdtime.gov.tw watch.stdtime.gov.tw,0x1"
