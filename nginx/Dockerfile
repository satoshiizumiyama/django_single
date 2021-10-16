FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]

ARG home_arg=/home/vscode
ENV HOME /home/vscode
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN apt-get update
RUN apt-get -y upgrade

#RUN apt-get install -y tzdata
RUN apt-get install -y libbz2-dev
RUN apt-get install -y liblzma-dev
RUN apt-get install -y wget curl python-dev python3-pip build-essential libffi-dev libssl-dev zlib1g-dev git
RUN apt-get install -y libsqlite3-dev libreadline6-dev libsqlite3-dev libncursesw5-dev libdb-dev libexpat1-dev libgdbm-dev libmpdec-dev
RUN apt-get install -y vim nginx

#ENV PYENV_ROOT $HOME/.pyenv
#ENV PATH $PYENV_ROOT/bin:$PATH

#RUN git clone https://github.com/pyenv/pyenv.git ${home_arg}/.pyenv
#WORKDIR ${home_arg}/.pyenv
#RUN git checkout v2.0.3

#RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
#RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
#RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
WORKDIR $HOME

# can't find path of pyenv
#RUN env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.8.6
#RUN pyenv global 3.8.6
#COPY requirements.txt /home/vscode
#RUN source ${home_arg}/.bashrc

#RUN ${home_arg}/.pyenv/shims/pip3 install -r requirements.txt

COPY setting/app_nginx.conf ${home_arg}
COPY setting/uwsgi_params ${home_arg}
RUN cp ${home_arg}/app_nginx.conf /etc/nginx/conf.d
RUN cp ${home_arg}/uwsgi_params /etc/nginx/

#CMD service nginx start
# can't use environment ver without arg
#RUN export PATH="$PATH:/root/.pyenv/versions/3.8.6/bin"


