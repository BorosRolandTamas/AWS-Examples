#!/usr/bin/env bash

sudo apt-get update
                sudo apt-get install -y wget apt-transport-https software-properties-common
                sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"
                sudo apt-get update
                sudo apt-get install -y powershell
                pwsh