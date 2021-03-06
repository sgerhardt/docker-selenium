#!/usr/bin/env bash

SEL_STATUS_URL="http://localhost:${SELENIUM_NODE_RC_CH_PORT}/wd/hub/status"

# set -e: exit asap if a command exits with a non-zero status
set -e

if [ "${RC_CHROME}" != "true" ]; then
  echo "Won't start selenium IDE RC node chrome due to CHROME env var false"
  exit 0
fi

echo "Waiting for Selenium IDE RC Node Chrome ${CHROME_FLAVOR} to be ready..."
# This is annoying but json endpoint /wd/hub/status returns different things
#  - on grid/hub .status should be 13
#  - on node .state should be "success"
while ! curl -s "${SEL_STATUS_URL}" | jq '.state' | grep "success"; do
  echo -n '.'
  sleep 0.1
done
echo "Done wait-selenium-rc-chrome-${CHROME_FLAVOR}.sh"
