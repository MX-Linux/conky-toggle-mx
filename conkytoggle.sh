#!/bin/bash
# Filename:      conkytoggleflux.sh
# Purpose:       toggle conky on/off from fluxbox menu
# Authors:       Kerry and anticapitalista, secipolla for antiX
# Authors:       modified for mx linux version 17 by dolphin oracle
# Latest change: Sun December 10, 2017.
################################################################################

main()
{
if pidof conky | grep [0-9] > /dev/null
 then
  killall conky 
  autostart_off
 else
    test=$(grep -q "conky -c" /home/$USER/.conky/conky-startup.sh && echo $?)
    if [ "$test" = "0" ]; then
         launch_conky
         autostart_on
    else
    conky-manager &
    fi
fi
}

launch_conky()
{    
SLEEP=$(grep sleep /home/$USER/.conky/conky-startup.sh|cut -d\   -f2)
echo $SLEEP
sed -i s/sleep.*/sleep\ 1s/ /home/$USER/.conky/conky-startup.sh

sh /home/$USER/.conky/conky-startup.sh &

sed -i s/sleep.*/sleep\ $SLEEP/ /home/$USER/.conky/conky-startup.sh
}

autostart_off()
{
    
if [ -e /home/$USER/.config/autostart/conky.desktop ]; then 
    sed -i -r s/Hidden=.*/Hidden=true/ /home/$USER/.config/autostart/conky.desktop
fi

}

autostart_on()
{
    
if [ -e /home/$USER/.config/autostart/conky.desktop ]; then 
    sed -i -r s/Hidden=.*/Hidden=false/ /home/$USER/.config/autostart/conky.desktop
fi

}

main
exit 0
