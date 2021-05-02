# This is used to test the installation script.

FROM ubuntu:latest

RUN apt update -y && apt full-upgrade -y
RUN apt install -y curl git rsync silversearcher-ag zsh

#################

# FROM debian:latest
#
# RUN apt update -y && apt full-upgrade -y
# RUN apt install -y curl git rsync silversearcher-ag zsh

#################

# FROM fedora:latest
#
# RUN dnf install -y curl findutils git rsync the_silver_searcher zsh

#################

ENV APPLICATION_USER dotfiles_test
RUN adduser $APPLICATION_USER

WORKDIR /app
RUN chown -R $APPLICATION_USER /app

USER $APPLICATION_USER

COPY ./install /app/install

SHELL ["zsh"]
RUN ./install.zsh
