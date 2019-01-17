#wpa_passphrase <SSID> <PASS> > /etc/wpa_supplicant/wpa_supplicant.conf
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
killall wpa_supplicant
killall dhcpcd
wpa_supplicant -B -i wlp3s0 -c /etc/wpa_supplicant/wpa_supplicant.conf 
dhcpcd wlp3s0
