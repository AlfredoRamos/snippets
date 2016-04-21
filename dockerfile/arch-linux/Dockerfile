FROM base/archlinux
MAINTAINER Alfredo Ramos <alfredo.ramos@yandex.com>

# Fix package signature problems
RUN pacman -Syy --noconfirm archlinux-keyring
RUN pacman-key --init
RUN pacman-key --populate archlinux
RUN pacman-key --refresh-keys
RUN pacman-key --updatedb

# Upgrade system
RUN pacman -Syyu --noconfirm
RUN pacman -Scc --noconfirm
RUN pacman-db-upgrade
