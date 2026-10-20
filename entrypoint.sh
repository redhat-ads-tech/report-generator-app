#!/bin/sh
mkdir -p /tmp/static
printf '{"sha":"%s","message":"%s","date":"%s"}' \
  "${REVISION_SHA}" "${REVISION_MSG}" "${REVISION_DATE}" \
  > /tmp/static/revision.json
exec java -jar /deployments/app.jar
