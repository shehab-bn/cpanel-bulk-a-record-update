#!/bin/bash

# Define the old and new IP addresses
OLD_IP="192.33.22.1"
NEW_IP="172.2.3.3"

# Define the directory where the DNS zone files are located
ZONE_DIR="/var/named"  # Adjust this path based on your actual DNS zone file location

# Function to update A records
update_a_records() {
    local zone_file=$1
    echo "Processing $zone_file..."
    sudo sed -i "s/$OLD_IP/$NEW_IP/g" "$zone_file"
}

# Loop through each DNS zone file in the directory
for zone_file in $ZONE_DIR/*.db; do
    update_a_records "$zone_file"
done

# Restart the DNS service to apply changes
sudo systemctl restart named  # or `sudo systemctl restart bind9` for some systems

echo "A record IP addresses updated successfully."
