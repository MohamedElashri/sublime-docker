FROM ubuntu:latest

LABEL com.sublime.package-name="sublime-text-3/docker-image"
LABEL version="0.0.1"
LABEL description="Docker image for Sublime Text 3. \
This allow us to run the Sublime Text 3 from inside a Docker Container. \

"

ENV NO_AT_BRIDGE=1

# Do not prompt for questions
ARG DEBIAN_FRONTEND=noninteractive

ARG HOST_USER="${HOST_USER:-sublime}"
ARG HOST_UID="${HOST_UID:-2000}"
ARG HOST_GID="${HOST_GID:-2000}"
ARG SUBLIME_BUILD="${SUBLIME_BUILD:-3126}"

RUN apt-get update && \
    apt-get -y upgrade && \

    # Install Required Dependencies
    apt-get -y install \
        ca-certificates \
        apt-utils \
        dbus-x11 \
        curl \
        git \
        python \
        php7.0 \
        libcanberra-gtk-module \
        libgtk2.0-0 \
        libatk-adaptor \
        libgail-common && \

        # Force Install of missing dependencies
        apt-get -y -f install && \

        # Localization
        locale-gen en_GB.UTF-8 && \

        # Cleanup
        rm -rf /var/lib/apt/lists/* && \

        #Add new sudo user
        useradd -m "${HOST_USER}" && \
        echo "${HOST_USER}:${HOST_USER}" | chpasswd && \
        usermod --shell /bin/bash "${HOST_USER}" && \
        usermod  --uid "${HOST_UID}" "${HOST_USER}" && \
        groupmod --gid "${HOST_GID}" "${HOST_USER}" && \
        su "${HOST_USER}" -c 'mkdir -p /home/${HOST_USER}/.local/share' && \

        # Install Sublime
        curl -O https://download.sublimetext.com/sublime-text_build-"${SUBLIME_BUILD}"_amd64.deb && \
        dpkg -i -R sublime-text_build-"${SUBLIME_BUILD}"_amd64.deb || echo "\n Will force install of missing ST3 dependencies...\n" && \

        # Force installation of missing dependencies for Visual Studio Code
        apt-get -y -f install && \
        rm -rvf sublime-text_build-"${SUBLIME_BUILD}"_amd64.deb

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8
ENV SHELL /bin/bash

# Run Sublime
CMD ["/opt/sublime_text/sublime_text", "-w"]
