
# OS Version
FROM ubuntu:22.04

# Update & Upgrade
RUN apt update && apt upgrade

###############################################################################################

# Install base library
RUN apt install build-essential libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev \
  libreadline-dev libsqlite3-dev libopencv-dev tk-dev git

# Setup Path of Pyenv
RUN echo '' >> ~/.bashrc
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
RUN source ~/.bashrc

# Install Python 
RUN pyenv install 3.11.4 
RUN pyenv global 3.11.4

###############################################################################################

# Entry Point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]