#!/bin/bash
#SERVER_IP="132.239.10.209"
SERVER_IP="54.200.164.190"
SERVER_PORT=5222
TOTAL_CLIENTS=100
MESSAGES_PER_CLIENT=20000
MESSAGE_SIZE=512
CLIENT_MESSAGE_DELAY=1
NUMBER_OF_CONTACTS=10

if [ -z $1 ]; then
    INPUT_FILE="input.txt"
    BASE_PATH=""
else
    INPUT_FILE=$1
    BASE_PATH="/home/ubuntu/simulator/"
fi

#ant && java -jar dist/lib/simulator.jar "$SERVER_IP" "$SERVER_PORT" "$TOTAL_CLIENTS" "$MESSAGES_PER_CLIENT" "$MESSAGE_SIZE" "$CLIENT_MESSAGE_DELAY" "$NUMBER_OF_CONTACTS" < input.txt
echo "input file is set to $INPUT_FILE"
java -jar "${BASE_PATH}dist/lib/simulator.jar" "$SERVER_IP" "$SERVER_PORT" "$TOTAL_CLIENTS" "$MESSAGES_PER_CLIENT" "$MESSAGE_SIZE" "$CLIENT_MESSAGE_DELAY" "$NUMBER_OF_CONTACTS" < "$INPUT_FILE"
