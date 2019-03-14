status=`nmcli dev status | grep "wlp2s0" | awk '{print $3}'`

if [[ "$status" == "connected" ]]; then
    echo `iw dev wlp2s0 link | grep "SSID:" | awk '{print $2}'` "-" `ifconfig wlp2s0 | grep 'inet ' | awk '{ print $2 }'`
else
    exit 1
fi