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
    test=$(grep -q "conky -c" "$HOME"/.conky/conky-startup.sh && echo $?)
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

CONKY_TEMP=$(mktemp --tmpdir=${XDG_RUNTIME_DIR:-/tmp} conky-startup.sh.XXXXXXXXXXXX)

sed -e 's/^[[:space:]]*sleep.*/sleep 1s/' "$HOME"/.conky/conky-startup.sh > $CONKY_TEMP

sh $CONKY_TEMP

rm $CONKY_TEMP

}

autostart_off()
{
    
if [ -e "$HOME"/.config/autostart/conky.desktop ]; then 
    sed -i -r s/Hidden=.*/Hidden=true/ "$HOME"/.config/autostart/conky.desktop
fi

}

autostart_on()
{
    
if [ -e $HOME/.config/autostart/conky.desktop ]; then 
    sed -i -r s/Hidden=.*/Hidden=false/ $HOME/.config/autostart/conky.desktop
fi

}

main
exit 0
