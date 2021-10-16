FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]

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
RUN apt install -y apache2 apache2-dev vim locales-all

ENV HOME /home/vscode
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN git clone https://github.com/pyenv/pyenv.git /home/vscode/.pyenv
WORKDIR /home/vscode/.pyenv
RUN git checkout v2.0.3

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
WORKDIR /home/vscode

# can't find path of pyenv
RUN env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.8.6
#RUN pyenv install 3.8.6
RUN pyenv global 3.8.6
COPY requirements.txt /home/vscode
RUN source /home/vscode/.bashrc

RUN /home/vscode/.pyenv/shims/pip3 install -r requirements.txt

COPY ./setting/apache2.conf /etc/apache2/
COPY ./setting/django.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite django
#CMD ["apache2ctl", "restart"]