FROM base/archlinux
MAINTAINER Alfredo Ramos <alfredo.ramos@yandex.com>

# Generate up-to-date mirrorlist (USA)
# https://www.archlinux.org/mirrorlist/
RUN curl -o /etc/pacman.d/mirrorlist 'https://www.archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on'
RUN sed -ri 's|^#(S)|\1|g' /etc/pacman.d/mirrorlist

# Fix package signature problems
RUN pacman -Syy --noconfirm --noprogressbar archlinux-keyring
RUN pacman-key --init
RUN pacman-key --populate archlinux
RUN pacman-key --refresh-keys
RUN pacman-key --updatedb

# Upgrade system
RUN pacman -Syyu --noconfirm --noprogressbar
RUN pacman-db-upgrade
RUN yes | pacman -Scc
