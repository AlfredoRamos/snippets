FROM base/archlinux
MAINTAINER Alfredo Ramos <alfredo.ramos@yandex.com>

#########################
# Set up Arch Linux
#########################

# Get build arguments
ARG user

# Set environment variables
ENV USER "${user}"
ENV HOME /home/"${USER}"

# Update mirrorlist
ADD bin/update-mirrorlist "${HOME}"/bin/
RUN "${HOME}"/bin/update-mirrorlist

# Update configuration files
ADD config/ignorepkg "${HOME}"/
ADD bin/update-ignorepkg "${HOME}"/bin/
RUN "${HOME}"/bin/update-ignorepkg

# Fix package signature problems
RUN pacman -Syy --noconfirm --noprogressbar archlinux-keyring
RUN pacman-key --init
RUN pacman-key --populate archlinux
RUN pacman-key --refresh-keys

# Upgrade system
RUN pacman -Syyu --noconfirm --noprogressbar
RUN pacman-db-upgrade
RUN update-ca-trust

# Create new user and update permissions
RUN useradd -mU "${USER}"
RUN chown -R "${USER}":"${USER}" "${HOME}"

# Clean image
ADD bin/clean-image "${HOME}"/bin/
RUN "${HOME}"/bin/clean-image
