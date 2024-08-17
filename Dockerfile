

# ベースイメージ
FROM ubuntu:22.04

# User
ARG USER_NAME="ryo_udon"
ARG USER_PASSWORD="ryo_udon"
ARG PYTHON_VERSION="3.12.4"

USER root

# update & upgrade

RUN apt update -y && apt upgrade -y

# vimなどのインストール

RUN apt install -y vim 


#RUN apt-get install -y vim 

# 言語設定

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

# 作業ディレクトリ作成

RUN mkdir -p /workspace

# 作業ディレクトリの指定
WORKDIR /workspace

# Install base library for pyenv
RUN apt install -y git

RUN apt install -y --no-install-recommends \
                    build-essential \
                    libssl-dev \
		            libffi-dev \
		            zlib1g-dev \
		            libbz2-dev \
		            libreadline-dev \
		            libsqlite3-dev \
                    wget \
                    curl \
		            llvm \
		            libncurses5-dev \
		            xz-utils \
		            libxml2-dev \
		            libxmlsec1-dev \
		            liblzma-dev 
		            #tk-dev \

#RUN apt install -y libhdf5-dev

# Install Python 
RUN wget --no-check-certificate https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
&& tar -xf Python-${PYTHON_VERSION}.tgz \
&& cd Python-${PYTHON_VERSION} \
&& ./configure --enable-optimizations\
&& make \
&& make install

RUN apt autoremove -y

# Set EntryPoint
#ENTRYPOINT [ "/usr/bin", "--" ]

# Remove apt Cache
RUN apt-get autoremove -y && apt-get clean && \
    rm -rf /usr/local/src/*

# Add User 
RUN groupadd -g 1000 developer &&\
  useradd -g developer -G sudo -m -s /bin/bash ${USER_NAME} &&\
  echo "${USER_NAME}:${USER_PASSWORD}" 

RUN 


# Insatll pyenv
#ENV HOME /home/${USER_NAME}
#ENV PYENV_ROOT $HOME/.pyenv
#ENV PATH $PYENV_ROOT/bin:$PATH
#
#RUN git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv 
#RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc && \
#    eval "$(pyenv init --path)"


# Setup Path of Pyenv


#ENV PATH $PYENV_ROOT:$HOME/.pyenv
#ENV PATH $PATH:$PYENV_ROOT/bin
#RUN echo '' >> /root/.bashrc
#RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /root/.bashrc
#RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
#RUN echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> /root/.bashrc
#RUN echo 'eval "$(pyenv init -)"' >> /root/.bashrc
#RUN echo 'eval "$(pyenv init --path)"' >> /root/.bashrc
#RUN echo 'eval "$(pyenv virtualenv-init -)"' >> /root/.bashrc

## Install Python
#RUN curl https://pyenv.run | bash
#RUN ["/bin/bash" "-c", "source /root/.bashrc && pyenv install 3.11.4"]
#RUN ["/bin/bash" "-c", "source /root/.bashrc && pyenv global 3.11.4"]
#RUN pyenv install 3.11.4
#RUN pyenv global 3.11.4
#RUN pyenv rehash


## sourceコマンドを使うため実行
RUN cat ~/.bashrc
RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN source ~/.bashrc

#RUN source /root/.bashrc \
#        && pyenv install 3.11.4 
#RUN source /root/.bashrc \
#        && pyenv global 3.11.4

# 必要なパッケージのインストール

COPY requirements.txt /workspace



RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
#RUN pip3 install --no-binary h5py h5py
RUN pip3 install --no-cache-dir -r requirements.txt


#RUN [ "pip", "install", "--upgrade pip" ]
#RUN [ "pip", "install", "--upgrade setuptools" ]
#RUN [ "pip", "install", "--no-cache-dir -r requirements.txt" ]

USER ${USER_NAME}

CMD ["/bin/bash"]
