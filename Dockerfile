FROM ubuntu:latest
MAINTAINER Ouray Viney "ouray@viney.ca"
RUN apt-get update
RUN apt-get install -y curl gpg apt-utils
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y code libasound2 libxtst6 libnss3 git 
RUN useradd -m vscode -s /bin/bash

WORKDIR /home/vscode

CMD su - vscode -c code -w .