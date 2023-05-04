#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

FROM debian:bullseye

# https://signalwire.com/docs/signalwire-cli/installation/
ARG SIGNALWIRE_TOKEN=GenerateYourOwnToken 

# Install git, process tools
RUN apt-get update && apt-get -y install git procps wget tree gnupg2 wget lsb-release apt-transport-https

# Install C++ tools
RUN apt-get -y install build-essential cmake cppcheck valgrind pkg-config 

# Install Freeswitch dev
RUN wget --http-user=signalwire --http-password=$SIGNALWIRE_TOKEN -O - https://freeswitch.signalwire.com/repo/deb/debian-release/signalwire-freeswitch-repo.gpg | apt-key add -

RUN echo "machine freeswitch.signalwire.com login signalwire password $SIGNALWIRE_TOKEN" > /etc/apt/auth.conf

RUN echo "deb https://freeswitch.signalwire.com/repo/deb/freeswitch-1.8/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list
RUN echo "deb-src https://freeswitch.signalwire.com/repo/deb/freeswitch-1.8/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list

RUN apt-get update
RUN apt-get -y installsoftware-properties-common
RUN add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/7.3 stable main"
RUN add-apt-repository "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main"
RUN apt-get -y install libfreeswitch-dev librdkafka-dev libz-dev libssl-dev

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y 
#   && rm -rf /var/lib/apt/lists/*

#INSERT_HERE

# Set the default shell to bash instead of sh
ENV SHELL /bin/bash