#!/bin/bash
set -e
echo "installing the plugin"
./kibana/bin/kibana-plugin install $(./transfer upload target/mathlion-${KIBANA_VERSION}.zip)

echo "starting kibana in the background"
nohup bash -c "./kibana/bin/kibana --no-ssl>&1 &"

echo "Waiting for 120 seconds..."
sleep 120

echo "Kibana log:"
cat nohup.out

echo "Checks for error in the kibana log of the last 120 seconds"
! grep -Fxq "error" nohup.out
! grep -Fxq "Skipping non-plugin directory" nohup.out