FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]

ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN apt-get update
RUN apt-get -y upgrade

#RUN apt-get install -y tzdata
RUN apt-get install -y libbz2-dev
RUN apt-get install -y liblzma-dev
RUN apt-get install -y wget curl python-dev python3-pip build-essential libffi-dev libssl-dev zlib1g-dev git
RUN apt-get install -y libsqlite3-dev libreadline6-dev libsqlite3-dev libncursesw5-dev libdb-dev libexpat1-dev libgdbm-dev libmpdec-dev

ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv
WORKDIR /root/.pyenv
RUN git checkout v2.0.3

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
WORKDIR /root

# can't find path of pyenv
RUN pyenv install -s  3.8.5
RUN pyenv global 3.8.5
COPY ./requirements.txt /root
RUN source /root/.bashrc

RUN /root/.pyenv/shims/pip3 install -r requirements.txt

# can't use environment ver without arg
#RUN export PATH="$PATH:/root/.pyenv/versions/3.8.5/bin"


