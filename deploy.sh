#!/bin/bash

# Exit immediately if any command fails
set -e

# 1. Remove the default NGINX welcome page if it exists
echo "Removing default NGINX welcome page..."
sudo rm -f /var/www/html/index.nginx-debian.html || echo "No default welcome page to remove"

# 2. Clone your own GitHub repo (if not already cloned)
echo "Cloning your GitHub repo..."
cd /tmp
rm -rf Weather-APP
git clone https://github.com/Waqas56jb/Weather-APP.git || {
    echo "Git clone failed"
    exit 1
}

# 3. Copy index.html to NGINX web root
echo "Copying index.html to /var/www/html..."
sudo cp /tmp/Weather-APP/index.html /var/www/html/ || {
    echo "Copy failed"
    exit 1
}

# 4. Set correct permissions
echo "Setting permissions for /var/www/html..."
sudo chown -R www-data:www-data /var/www/html || {
    echo "Permission setting failed"
    exit 1
}

# 5. Reload NGINX to apply changes
echo "Reloading NGINX..."
sudo systemctl reload nginx || {
    echo "NGINX reload failed"
    exit 1
}

echo "✅ Deployment completed successfully!"
