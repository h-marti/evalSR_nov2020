# Auto install & config GQ server
apt-get update
apt-get install apache2 curl -y

# Display info
echo "======================================"
echo "=                                    ="
echo "=   Run wireguard-install.sh again   ="
echo "=          to add a client           ="
echo "=                                    ="
echo "======================================"

echo ""
read -n1 -r -p "Press any key to continue..."


# Install and config wireguard
curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh
./wireguard-install.sh
