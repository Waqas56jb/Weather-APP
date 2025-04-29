#!/bin/bash

# Exit immediately if any command fails
set -e

# 1. Remove default nginx page (if exists)
echo "Removing default nginx page..."
sudo rm -f /var/www/html/index.nginx-debian.html || echo "No default nginx page found"

# 2. Download your updated weather app code from GitHub
echo "Downloading weather app from GitHub..."
wget -q --show-progress -O /tmp/weather.zip https://github.com/muhammadsohaib56/weather-forecast-web/archive/refs/heads/main.zip || {
    echo "Failed to download from GitHub"
    exit 1
}

# 3. Unzip the downloaded code
echo "Unzipping weather app..."
unzip -q -o /tmp/weather.zip -d /tmp/ || {
    echo "Failed to unzip weather app"
    exit 1
}

# 4. Copy your app files into the Nginx root directory
echo "Copying files to web root..."
sudo cp -r /tmp/weather-forecast-web-main/* /var/www/html/ || {
    echo "Failed to copy files to web root"
    exit 1
}

# 5. Set correct permissions for the web server
echo "Setting permissions..."
sudo chown -R www-data:www-data /var/www/html || {
    echo "Failed to set permissions"
    exit 1
}

# 6. Reload nginx to apply changes
echo "Reloading nginx..."
sudo systemctl reload nginx || {
    echo "Failed to reload nginx"
    exit 1
}

echo "Deployment completed successfully!"
