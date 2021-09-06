    USER_NAME="docker-sublime"
    IMAGE_NAME="melashri/sublime"

    # Where to persist Sublime settings, cache and installed packages.
    HOST_SUBLIME_DIR=/home/"$USER"/"${USER_NAME}"/.docker-sublime
    HOST_SUBLIME_CONFIG_DIR="${HOST_SUBLIME_DIR}"/.config/sublime-text-3


    
    TIMESTAMP=$( date +"%s" )

    CONTAINER_NAME="ST3_${TIMESTAMP}"

    # Setup X11 server authentication
    XSOCK=/tmp/.X11-unix
    XAUTH="${HOST_SUBLIME_DIR}"/x11dockerize

        mkdir -p "${HOST_SUBLIME_CONFIG_DIR}"

    # Setup X11 server bridge between host and container
    touch "${XAUTH}" &&
    xauth nlist "${DISPLAY}" | sed -e 's/^..../ffff/' | xauth -f "${XAUTH}" nmerge -
    chmod 644 "${XAUTH}" # not the most secure way, USE INSTEAD sublime cli

    # Run Container with X11 authentication and using same user in container and host
    sudo docker run --rm -it \
        --name="${CONTAINER_NAME}" \
        --workdir="${HOST_SUBLIME_DIR}" \
        --volume="${HOST_SUBLIME_CONFIG_DIR}":/home/"${USER_NAME}"/.config/sublime-text-3 \
        --volume="$PWD":/home/"${USER_NAME}"/developer \
        --volume="${XSOCK}":"${XSOCK}":ro \
        --volume="${XAUTH}":"${XAUTH}":ro \
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY" \
        --user="${USER_NAME}" \
        "${IMAGE_NAME}"
