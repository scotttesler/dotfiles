# This is used to test the installation script.

# # This requires `nvm install -s node`
# FROM alpine:latest
#
# RUN apk update && apk upgrade
# RUN apk add -fU curl git rsync zsh ca-certificates openssl ncurses coreutils python2 make gcc g++ libgcc linux-headers grep util-linux binutils findutils

#################

# FROM debian:latest
#
# RUN apt update -y && apt full-upgrade -y
# RUN apt install -y curl git rsync zsh

#################

FROM ubuntu:latest

RUN apt update -y && apt full-upgrade -y
RUN apt install -y curl git rsync zsh

#################

# FROM fedora:latest
#
# RUN dnf install -y curl find git rsync zsh

#################

ENV APPLICATION_USER dotfiles_test
RUN adduser $APPLICATION_USER

WORKDIR /app
RUN chown -R $APPLICATION_USER /app

USER $APPLICATION_USER

COPY ./install.zsh /app/install.zsh

SHELL ["zsh"]
RUN ./install.zsh
