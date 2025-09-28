#!/bin/bash
set -euo pipefail
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 curl
systemctl enable --now apache2
curl -L "https://raw.githubusercontent.com/ChuckKeyes/Class-Armageddon/main/Task3/index-us.html" \
  -o /var/www/html/index.html
systemctl restart apache2