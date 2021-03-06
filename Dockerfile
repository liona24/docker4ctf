FROM debian:latest

RUN apt-get update
RUN apt-get -y install curl wget python3-pip ltrace strace vim git cmake gdb python-pip python-dev libssl-dev libffi-dev tmux python3-dev build-essential unzip ruby gdbserver netcat

RUN pip install --upgrade pip
RUN pip3 install --upgrade pip

RUN python3 -m pip install --upgrade git+https://github.com/Gallopsled/pwntools.git@dev3

RUN cd /var/tmp && git clone https://github.com/keystone-engine/keystone.git && cd keystone && mkdir build && cd build && ../make-share.sh && make install && ldconfig && cd ../bindings/python && python3 setup.py install

RUN pip3 install virtualenv
RUN pip3 install unicorn ropper capstone
RUN pip3 install cryptography

RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

RUN cd $HOME && git clone https://github.com/liona24/utility-scripts.git && echo "export PATH=\"$PATH:$HOME/utility-scripts\"" >> $HOME/.bashrc

RUN gem install one_gadget

ENV LC_CTYPE C.UTF-8

RUN mkdir $HOME/share/
VOLUME ["$HOME/share"]

COPY tmux.conf root/.tmux.conf
COPY vimrc root/.vimrc

CMD bash
