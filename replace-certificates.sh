#!/bin/sh

sudo apt update
sudo apt install snapd -y
sudo snap install --classic certbot
sudo snap set certbot trust-plugin-with-root=ok
sudo snap install certbot-dns-google
printf "Creating new wildcard certificate\n" ; sleep 2
read -p "Enter Registered Domain: " DOMAIN_NAME
sudo certbot certonly --manual --preferred-challenges dns -d '*.'$DOMAIN_NAME
printf "Backing up default ingress certificates file\n" ; sleep 2
mv ~/bigbang/chart/ingress-certs.yaml ~/bigbang/chart/ingress-certs.yaml.bak
printf "Creating new certificates YAML file....\n" ; sleep 2
wget https://raw.githubusercontent.com/Operator-One/bigbangtls/main/ingress-certs.yaml
printf 'Copy the Private/Public Key from /etc/letsencrypt/live/$DOMAIN_NAME a line below the key: and cert: section\n of the new ingress-certs.yaml file\n'
printf 'After you should be good to then install/update your lab provided helm chart command\n'
