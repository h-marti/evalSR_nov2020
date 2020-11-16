# Auto install & config GQ server
apt-get update
apt-get install nginx

# Display info
echo "======================================"
echo "=                                    ="
echo "=   Run wireguard-install.sh again   ="
echo "=          to add a client           ="
echo "=                                    ="
echo "======================================"

echo ""
read -p "Continue [y/n]" confirm

if [ $confirm -eq "n" ]
then
  exit 1
fi


# Install and config wireguard
curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh
./wireguard-install.sh
