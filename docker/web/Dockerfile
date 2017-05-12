FROM ubuntu:16.04

# Set the locale, otherwise elixir will complain later on
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get -y update
RUN apt-get -y upgrade


# wget for convenience, use curl if you want to
RUN apt-get -y install wget unzip bzip2 apt-utils imagemagick git


# add erlang otp
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get install -y -q imagemagick esl-erlang elixir

RUN apt-get install -y nodejs-legacy npm build-essential

ENV HOME /root
ADD ssh/ /root/.ssh/
RUN chmod 600 /root/.ssh/*
RUN ssh-keyscan bitbucket.org > /root/.ssh/known_hosts

WORKDIR /root
RUN git clone git@bitbucket.org:longyee/h3acatalog.git

WORKDIR /root/h3acatalog
RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
RUN mix deps.get
#RUN vi config/dev.exs
#RUN mix ecto.create
#RUN mix ecto.migrate
RUN npm install
#RUN mix phoenix.server
CMD ["mix", "phoenix.server"]
