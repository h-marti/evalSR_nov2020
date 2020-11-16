# Auto install & config wireguard client on linux

# Auto install
echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/source.list
apt-get update
apt-get -t buster-backports install wireguard

# User confirmation
ls -l
read -e -p 'Config file: ' file

# Config
cp $file /etc/wireguard/wg0.conf
sudo chmod 600 /etc/wireguard/wg0.conf

# Start now
wg-quick up wg0

# Start on boot
systemctl enable wg-quick@wg0
