#!/bin/bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

echo "Testing the mongodb container"

cid="$(
	docker run -d \
	  -e DEBUG \
		--name "${NAME}" \
		"${IMAGE}"
)"
trap "docker rm -vf ${cid} > /dev/null" EXIT

mongodb() {
	docker run --rm -i \
	    -e DEBUG  \
	    -v /tmp:/mnt \
	    --link "${NAME}":"${MONGODB_HOST}" \
	    "${IMAGE}" \
	    "${@}" \
	    host="${MONGODB_HOST}"
}
