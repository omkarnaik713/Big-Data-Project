#!/bin/bash

# PART 1 ==> UNZIP, DECOMPRESS AND COPY DATASET TO HDFS

./dataset-load.sh


# PART 2 ==> COPY MAPRED AND CONFIG TO HDFS
./config-load.sh