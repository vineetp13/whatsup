#!/bin/bash
for server in "$@"
do
    ssh "$server" "nohup ./whatsup/simulator/run.sh ~/whatsup/simulator/${server}.input > output.log &"
done
