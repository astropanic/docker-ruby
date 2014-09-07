FROM phusion/baseimage:0.9.13
MAINTAINER Wojciech Pietrzak <act.as.coder@gmail.com>

RUN apt-get -y update

RUN apt-get install -y -q git curl
RUN apt-get -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev

RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN bash -lc 'rbenv install 2.1.2'
RUN bash -lc 'rbenv global 2.1.2'
RUN adduser --disabled-password --gecos "" plumber
RUN echo 'export GEM_HOME="$HOME/.gem"' >> /home/plumber/.profile
RUN echo 'export GEM_PATH="$HOME/.gem"' >> /home/plumber/.profile
RUN echo 'export PATH="$HOME/.gem/bin:$PATH"' >> /home/plumber/.profile
RUN echo 'gem: --no-rdoc --no-ri' >> /home/plumber/.gemrc
RUN su plumber -lc 'gem install bundler'

