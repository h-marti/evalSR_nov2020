# Auto install & config wireguard client on linux

# Auto install
if grep -Fxq 'deb http://deb.debian.org/debian buster-backports main' /etc/apt/sources.list
then
    echo "[*] sources.list OK"
else
    echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list
fi

apt-get update
apt-get upgrade -y


apt-get -t buster-backports install wireguard -y
apt-get -t buster-backports install linux-headers-$(uname -r) -y

# Display info
echo ""
echo ""
echo "[*] Reboot and run again in case of fail..."
echo ""

read -n1 -r -p "Press any key to continue..."

# User confirmation
ls -l
read  -p 'Config file: ' file

# Config
cp $file /etc/wireguard/wg0.conf
chmod 600 /etc/wireguard/wg0.conf

# Start now
wg-quick up wg0

# Start on boot
systemctl enable wg-quick@wg0
