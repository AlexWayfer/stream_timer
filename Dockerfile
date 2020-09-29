FROM debian:latest

MAINTAINER Alexander Popov <alex.wayfer@gmail.com>

ARG port

RUN apt-get update -qq && apt-get install -y \
	## For `rbenv` and `nodenv`
	curl git gcc make \
	## For Ruby
	autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev \
	## For Ruby gems
	libpq-dev

RUN adduser --gecos '' --disabled-password stream_timer
USER stream_timer
ENV HOME /home/stream_timer

## Install `rbenv` and `ruby-build`
ENV PATH $HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

## Install `nodenv` and `node-build`
ENV PATH $HOME/.nodenv/shims:$HOME/.nodenv/bin:$HOME/.nodenv/plugins/node-build/bin:$PATH
RUN curl -fsSL https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer | bash

ARG project_path=/home/stream_timer/stream_timer

RUN mkdir $project_path
WORKDIR $project_path
COPY --chown=stream_timer:stream_timer . $project_path

RUN exe/setup.sh

EXPOSE ${port}

CMD ["bundle", "exec", "toys", "server", "start"]
