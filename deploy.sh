#!/bin/sh
# deploy.sh
#
# Deploy h3acatalog on ubuntu 16.04.

# Detect OS version
BITS=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
if [ -f /etc/centos-release ]; then
    OS="CentOS"
    VER=$(cat /etc/centos-release | sed 's/^.*release //;s/ (Fin.*$//')
else
    OS=$(uname -s)
    VER=$(uname -r)
fi
echo "Detected : $OS  $VER  $BITS"

# Upgrade the system
sudo apt-get update
sudo apt-get upgrade -y

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install esl-erlang -y
sudo apt-get install elixir -y

sudo apt-get install nodejs-legacy npm -y
sudo apt-get install build-essential -y

sudo apt-get install postgresql postgresql-contrib -y
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"

mix local.hex
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

git clone https://longyee@bitbucket.org/longyee/h3acatalog.git
cd h3acatalog
mix deps.get
mix ecto.create
mix ecto.migrate
npm install
mix phoenix.server
