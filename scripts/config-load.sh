#!/bin/bash

# Define the local directories for configuration files and scripts
CONFIG_DIR="/tmp/config"
SCRIPTS_DIR="/tmp/mapred"

# Define the HDFS destination directories
HDFS_CONFIG_DIR="/user/airline_data/config"
HDFS_SCRIPTS_DIR="/user/airline_data/mapred"

# Create the HDFS directories if they don't exist
sudo -u hdfs hdfs dfs -mkdir -p $HDFS_CONFIG_DIR
sudo -u hdfs hdfs dfs -mkdir -p $HDFS_SCRIPTS_DIR

#Moving config and mapred files tempararily to /tmp
cp -R /home/ec2-user/Big-Data-Project/config /tmp
cp -R /home/ec2-user/Big-Data-Project/mapred /tmp

# Copy all config files to HDFS
echo "Copying config files to HDFS..."
for config_file in $CONFIG_DIR/*; do
    if [[ -f $config_file ]]; then
        sudo -u hdfs hdfs dfs -put $config_file $HDFS_CONFIG_DIR/
        echo "Copied: $config_file to $HDFS_CONFIG_DIR/"
    fi
done

# Copy all scripts to HDFS
echo "Copying scripts to HDFS..."
for script_file in $SCRIPTS_DIR/*; do
    if [[ -f $script_file ]]; then
        sudo -u hdfs hdfs dfs -put $script_file $HDFS_SCRIPTS_DIR/
        echo "Copied: $script_file to $HDFS_SCRIPTS_DIR/"
    fi
done

#Cleanup
rm -rf /tmp/config /tmp/mapred

echo "Copy operation complete!"