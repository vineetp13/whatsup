#!/bin/bash
SERVER_IP="openfirexlarge-1401848335.us-west-2.elb.amazonaws.com"
SERVER_PORT=5222
TOTAL_CLIENTS=1600
MESSAGES_PER_CLIENT=500
MESSAGE_SIZE=128
#CLIENT_MESSAGE_DELAY=1
CLIENT_MESSAGE_DELAY=0
NUMBER_OF_CONTACTS=10

if [ -z $1 ]; then
    INPUT_FILE="input.txt"
    BASE_PATH=""
else
    INPUT_FILE=$1
    BASE_PATH="/home/ubuntu/whatsup/simulator/"
fi

#ant && java -jar dist/lib/simulator.jar "$SERVER_IP" "$SERVER_PORT" "$TOTAL_CLIENTS" "$MESSAGES_PER_CLIENT" "$MESSAGE_SIZE" "$CLIENT_MESSAGE_DELAY" "$NUMBER_OF_CONTACTS" < input.txt
echo "input file is set to $INPUT_FILE"
java -Xms3G -Xmx4G -jar "${BASE_PATH}dist/lib/simulator.jar" "$SERVER_IP" "$SERVER_PORT" "$TOTAL_CLIENTS" "$MESSAGES_PER_CLIENT" "$MESSAGE_SIZE" "$CLIENT_MESSAGE_DELAY" "$NUMBER_OF_CONTACTS" < "$INPUT_FILE"
