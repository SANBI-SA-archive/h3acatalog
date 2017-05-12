FROM ubuntu:14.04
LABEL Name=web Version="0.1"
# Set the locale, otherwise elixir will complain later on
RUN apt-get -y update ; apt-get -y upgrade
RUN apt-get install locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
# wget for convenience, use curl if you want to
RUN apt-get -y install wget unzip bzip2 apt-utils imagemagick git \

# add erlang otp
&& apt-get install -y build-essential
RUN apt-get install -y curl; curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update ; apt-get install -y esl-erlang ; apt-get install -y elixir

ENV HOME /root
ADD ssh/ /root/.ssh/
RUN chmod 600 /root/.ssh/*
RUN ssh-keyscan bitbucket.org > /root/.ssh/known_hosts

WORKDIR /root
# RUN git clone git@bitbucket.org:longyee/h3acatalog.git
RUN git clone https://github.com/SANBI-SA/h3acatalog.git

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
