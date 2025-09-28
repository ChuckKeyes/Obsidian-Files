#!/bin/bash
set -euo pipefail

# Install Apache
apt-get update -y
apt-get install -y apache2 curl git

systemctl enable --now apache2

# Download index.html from GitHub repo
curl -L https://raw.githubusercontent.com/ChuckKeyes/Class-Armageddon/main/Task3/bbl-index.html \
  -o /var/www/html/index.html

# Restart Apache
systemctl restart apache2