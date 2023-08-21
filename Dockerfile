FROM python:3.9-slim
ARG USERNAME
ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

# Install required packages
RUN apt-get update && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install -y \
    apt \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg \
    locales \
    openssh-client \
    sudo \
    unzip \
    vim

# Add User
RUN groupadd --gid 1002 ${USERNAME} && \
    useradd --uid 1001 --gid ${USERNAME} --shell /bin/bash --create-home ${USERNAME} && \
    echo "%${USERNAME}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${USERNAME}

# Install AWS CLI and AWS SAM
RUN pip3 install --upgrade pip && \
    pip3 install awscli aws-sam-cli --upgrade


USER ${USERNAME}
ENV PATH /home/${USERNAME}/.local/bin:/home/${USERNAME}/bin:${PATH}

CMD ["/bin/sh"]
