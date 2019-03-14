status = `nmcli dev status | grep "wlp2s0" | awk '{print $3}'`

if [[ "$status" == "connected" ]]; then
    echo "Wired connection -" `ifconfig enp3s0 | grep 'inet ' | awk '{ print $2 }'`
else
    exit 1
fi