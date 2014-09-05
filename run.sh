#!/bin/sh

if test $# -lt 1; then
	# Get the latest opengl-nvidia build
	# and start with an interactive terminal enabled
	args="-i -t $(docker images | grep ^opengl-nvidia | head -n 1 | awk '{ print $1":"$2 }')"
else
        # Use this script with derived images, and pass your 'docker run' args
	args="$@"
fi

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run \
	--privileged \
	-v $XSOCK:$XSOCK:rw \
	-v $XAUTH:$XAUTH:rw \
	-v /dev/dri:/dev/dri:rw \
	-e DISPLAY=$DISPLAY \
	-e XAUTHORITY=$XAUTH \
	$args
