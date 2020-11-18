# Auto setup a PKI infrastructure to
# enable HTTPS on nginx

# 1.1 Create directories
mkdir -p ca/root-ca/private ca/root-ca/db crl certs
chmod 700 ca/root-ca/private

# 1.2 Create database
cp /dev/null ca/root-ca/db/root-ca.db
cp /dev/null ca/root-ca/db/root-ca.db.attr
echo 01 > ca/root-ca/db/root-ca.crt.srl
echo 01 > ca/root-ca/db/root-ca.crl.srl

# 1.3 Create CA request
openssl req -new \
    -config etc/root-ca.conf \
    -out ca/root-ca.csr \
    -keyout ca/root-ca/private/root-ca.key

# 1.4 Create CA certificate
openssl ca -selfsign \
    -config etc/root-ca.conf \
    -in ca/root-ca.csr \
    -out ca/root-ca.crt \
    -extensions root_ca_ext

# 2.1 Create directories
mkdir -p ca/signing-ca/private ca/signing-ca/db crl certs
chmod 700 ca/signing-ca/private

# 2.2 Create database
cp /dev/null ca/signing-ca/db/signing-ca.db
cp /dev/null ca/signing-ca/db/signing-ca.db.attr
echo 01 > ca/signing-ca/db/signing-ca.crt.srl
echo 01 > ca/signing-ca/db/signing-ca.crl.srl

# 2.3 Create CA request
openssl req -new \
    -config etc/signing-ca.conf \
    -out ca/signing-ca.csr \
    -keyout ca/signing-ca/private/signing-ca.key

#2.4 Create CA certificate
openssl ca \
    -config etc/root-ca.conf \
    -in ca/signing-ca.csr \
    -out ca/signing-ca.crt \
    -extensions signing_ca_ext

# 3.3 Create TLS server request
SAN=DNS:www.kiloupresquetout.local \
openssl req -new \
    -config etc/server.conf \
    -out certs/kiloupresquetout.local.csr \
    -keyout certs/kiloupresquetout.local.key

# 3.4 Create TLS server certificate
openssl ca \
    -config etc/signing-ca.conf \
    -in certs/kiloupresquetout.local.csr \
    -out certs/kiloupresquetout.local.crt \
    -extensions server_ext

# Export cert
cp ca/root-ca.crt ./root-ca.crt
mkdir /etc/ssl 2> /dev/null
cat certs/kiloupresquetout.local.crt ca/signing-ca.crt >> /etc/ssl/kiloupresquetout.local.pem
cp certs/kiloupresquetout.local.key /etc/ssl/kiloupresquetout.local.key 

# Setup nginx
echo "
server {
  listen443;
    ssl on;
    ssl_certificate /etc/ssl/kiloupresquetout.local.pem;
    ssl_certificate_key /etc/ssl/kiloupresquetout.local.key;
    server_name kiloupresquetout.local;
    access_log /var/log/nginx/nginx.vhost.access.log;
    error_log /var/log/nginx/nginx.vhost.error.log;
    location / {
        root  /home/www;
        index  index.html;
    }
}
" > /etc/nginx/sites-available

/etc/init.d/nginx restart