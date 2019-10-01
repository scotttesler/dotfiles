# This is used to test the installation script.

FROM debian:latest

RUN apt update -y && apt full-upgrade -y
RUN apt install -y git curl zsh rsync

ENV APPLICATION_USER dotfiles_test
RUN adduser $APPLICATION_USER

WORKDIR /app
RUN chown -R $APPLICATION_USER /app

USER $APPLICATION_USER

COPY ./install.zsh /app/install.zsh

SHELL ["zsh"]
RUN ./install.zsh
