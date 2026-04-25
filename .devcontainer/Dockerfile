FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Install AWS CLI, Ruby, Java, and Maven
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl unzip ruby-full ruby-bundler openjdk-21-jdk maven \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install Node.js via nvm (user-owned, allows global npm installs without sudo)
ENV NVM_DIR=/usr/local/nvm
RUN mkdir -p $NVM_DIR \
    && curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | NVM_DIR=$NVM_DIR bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install --lts \
    && nvm use --lts \
    && nvm alias default node \
    && chmod -R 777 $NVM_DIR \
    && echo ". $NVM_DIR/nvm.sh" >> /etc/bash.bashrc

# Install Terraform
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends gnupg software-properties-common \
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
       > /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update \
    && apt-get -y install --no-install-recommends terraform \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*
