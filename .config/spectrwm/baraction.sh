#!/bin/sh

## DISK
hdd() {
  hdd="$(df -h | awk 'NR==4{print $3}')"
  echo "HDD: $hdd"
}

## RAM
mem() {
  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo "$mem"
}

## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo "CPU: $cpu%"
}

## VOLUME
vol() {
    vol=`amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/'`
    echo "VOL: $vol"
}

SLEEP_SEC=3
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the 
# echo output too long to display correctly.
while :; do
    echo "+@fg=1; +@fn=0; $(cpu) +@fg=0; | +@fg=2;  $(mem) +@fg=0; | +@fg=3;+@fn=0; $(hdd) +@fg=0; | +@fg=4;+@fn=0; $(vol)% +@fg=0; | "
	sleep $SLEEP_SEC
done
