#!/bin/bash
NUM_MESSAGES=10
NUM_CONTACTS=10
TOTAL_CONTACTS=100
#DOMAIN_NAME="localhost"
DOMAIN_NAME="137.110.90.7"

sleep 2s
echo "$1@$DOMAIN_NAME"
sleep 1s
echo "$2"
sleep 1s

if [ -n "$3" ]; then
    TOTAL_CONTACTS=$3
fi

if [ $TOTAL_CONTACTS -lt $NUM_CONTACTS ]; then
    NUM_CONTACTS=$TOTAL_CONTACTS
fi

# remove all existing contacts
echo "remove-all"
sleep 10s

# add new contacts
declare -a CONTACTS
COUNTER=0
while [ $COUNTER -lt $NUM_CONTACTS ]; do

    CONTACT=$(( ( RANDOM % $TOTAL_CONTACTS )  + 1 ))

    if [ "$CONTACT" -ne "$1" ]; then
        CONTACTS[$COUNTER]=$CONTACT
        echo "add"
        sleep 1s
        echo "$CONTACT@$DOMAIN_NAME"
        sleep 1s
        let COUNTER=COUNTER+1
    fi
done

# sending messages
COUNTER=0
let TOTAL_MESSAGES=$NUM_CONTACTS*$NUM_MESSAGES
while [ $COUNTER -lt $TOTAL_MESSAGES ]; do

    CONTACT=${CONTACTS[$(( ( RANDOM % $NUM_CONTACTS ) ))]}

    echo "message"
    sleep 1s
    echo "$CONTACT@$DOMAIN_NAME"
    sleep 1s
    echo "hey $CONTACT! this is message #${COUNTER}"
    sleep 5s

    let COUNTER=COUNTER+1
done

# log
echo "total message sent: $TOTAL_MESSAGES"

# exit
echo "exit"
