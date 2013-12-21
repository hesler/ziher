#!/bin/bash

echo ====================== Przygowotuje maszyne...
sudo -H -u vagrant -i echo "export LANGUAGE=en_US.UTF-8" >> /etc/bash.bashrc
sudo -H -u vagrant -i echo "export LANG=en_US.UTF-8" >> /etc/bash.bashrc
sudo -H -u vagrant -i echo "export LC_ALL=en_US.UTF-8" >> /etc/bash.bashrc

locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#dpkg-reconfigure locales

DEBIAN_FRONTEND=noninteractive apt-get update

echo ====================== Instaluje RVM
DEBIAN_FRONTEND=noninteractive apt-get --yes install git curl
# there is a problem with twitter-bootstrap-rails and ruby 2.0 so let's use 1.9.3 instead
sudo -H -u vagrant -i bash -c "curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3"
sudo -H -u vagrant -i echo "source /home/vagrant/.rvm/scripts/rvm" >> /home/vagrant/.bashrc

# some ruby variables to make ZiHeR a wee bit faster
sudo -H -u vagrant -i echo "export RUBY_HEAP_MIN_SLOTS=800000" >> /home/vagrant/.bashrc
sudo -H -u vagrant -i echo "export RUBY_HEAP_FREE_MIN=100000" >> /home/vagrant/.bashrc
sudo -H -u vagrant -i echo "export RUBY_HEAP_SLOTS_INCREMENT=300000" >> /home/vagrant/.bashrc
sudo -H -u vagrant -i echo "export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1" >> /home/vagrant/.bashrc
sudo -H -u vagrant -i echo "export RUBY_GC_MALLOC_LIMIT=79000000" >> /home/vagrant/.bashrc

# https://github.com/mitchellh/vagrant/issues/866 - ~/.bashrc is not loaded in 'vagrant ssh' sessions
sudo -H -u vagrant -i echo "source ~/.bashrc" >> /home/vagrant/.bash_profile

echo ====================== Instaluje PostgreSQL
DEBIAN_FRONTEND=noninteractive apt-get --yes install libpq-dev postgresql postgresql-client
sudo -u postgres psql postgres -c "alter user postgres with password 'postgres'"
sudo -u postgres psql postgres -c "create user ziher with password 'ziher' createdb"
#sudo -u postgres sed -i -e 's/\(^local\s*all\s*all\s*\)\(peer$\)/\1md5/g' /etc/postgresql/9.1/main/pg_hba.conf
service postgresql restart

echo ====================== Sciagam kod zrodlowy ZiHeR-a
sudo -H -u vagrant -i git clone https://github.com/zhr/ziher.git
sudo -H -u vagrant -i bash -c "git config --global color.ui true"
#sudo -H -u vagrant -i bash -c "cd /home/vagrant/ziher; git checkout 1e00c66a45b723d"

echo ====================== Sciagam gemy i uzupelniam baze danych
sudo -H -u vagrant -i bash -c "cd /home/vagrant/ziher; bundle install"
sudo -H -u vagrant -i bash -c "cd /home/vagrant/ziher; rake db:create:all"
sudo -H -u vagrant -i bash -c "cd /home/vagrant/ziher; rake db:reset"

echo '====================== ZiHeR jest gotowy do zabawy!'
echo '====================== Aby zalogowac sie na maszyne wpisz'
echo '====================== $ vagrant ssh <enter>'
echo '======================'
echo '====================== Nastepnie wejdz do katalogu z ZiHeRem'
echo '====================== $ cd ziher <enter>'
echo '======================'
echo '====================== Po czym odpal serwer http ktory poda Ci ZiHeRa na tacy'
echo '====================== $ rails server <enter>'
echo '======================'
echo '====================== Po wykonaniu tych komend twoj wlasny i niepowtarzalny ZiHeR czeka na Ciebie :]'
echo '====================== W przegladarce wpisz: http://192.168.33.10:3000'
