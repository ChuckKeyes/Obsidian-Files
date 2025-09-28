#!/bin/bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive

# Fast, non-interactive install
apt-get update -y
apt-get install -y apache2 curl

# Enable + start Apache
systemctl enable --now apache2

# Metadata (no internet required)
MD="http://metadata.google.internal/computeMetadata/v1"
H="Metadata-Flavor: Google"

local_ipv4=$(curl -H "$H" -s "$MD/instance/network-interfaces/0/ip" || echo "unknown")
zone=$(curl -H "$H" -s "$MD/instance/zone" | awk -F/ '{print $NF}' || echo "unknown")
project_id=$(curl -H "$H" -s "$MD/project/project-id" || echo "unknown")
network_tags=$(curl -H "$H" -s "$MD/instance/tags" || echo "[]")

# Simple landing page
cat >/var/www/html/index.html <<EOF
<html><body>
<h1>Charles Keyes</h1>
<h2>Welcome to your Maryland web server</h2>
<p><b>Instance:</b> $(hostname -f)</p>
<p><b>Private IP:</b> ${local_ipv4}</p>
<p><b>Zone:</b> ${zone}</p>
<p><b>Project ID:</b> ${project_id}</p>
<p><b>Network Tags:</b> ${network_tags}</p>
</body></html>
EOF