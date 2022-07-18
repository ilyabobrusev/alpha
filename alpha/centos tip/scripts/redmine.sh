yes | yum upgrade
yum install -y wget
# измените версию redmine, если нужно / change redmine version number if need
REDMINE_VERSION="3.4.4"
# установите язык для redmine / set redmine language
REDMINE_LANGUAGE="ru"
# выключаем анбшный даллас-лок / disable selinux because it's can theat proper working
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config 
# Устанавливаем rpm пакет с ruby 
cd /tmp && wget https://github.com/feedforce/ruby-rpm/releases/download/2.4.3/ruby-2.4.3-1.el7.centos.x86_64.rpm
yum install -y ruby-2.4.3-1.el7.centos.x86_64.rpm
gem install bundler --no-ri --no-rdoc
# Качаем redmine / Download redmine 
wget http://www.redmine.org/releases/redmine-$REDMINE_VERSION.tar.gz
tar -xf redmine-$REDMINE_VERSION.tar.gz 
mv redmine-$REDMINE_VERSION /opt/redmine
cd /opt/redmine
# Добавляем нормальный веб-сервер puma / we'll use puma because webrick is sucks
echo 'gem "puma"' > Gemfile.local

cat > config/database.yml << EOL
production:
  adapter: sqlite3
  database: db/redmine.sqlite3
EOL
# устанавливаем компиляторы 
yum groupinstall -y "Development tools"
yum install -y ImageMagick ImageMagick-devel
yum install -y sqlite sqlite-devel
bundle install --without development test
# Генерируем токен для сессии 
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production REDMINE_LANG=$REDMINE_LANGUAGE bundle exec rake redmine:load_default_data
# Открываем 80 порт для веб-сервера / open 80 port for web-server
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
# Настройка smtp / SMTP config - http://www.redmine.org/projects/redmine/wiki/EmailConfiguration#GMail-Google-Apps
cp config/configuration.yml.example config/configuration.yml
# Простейшая отправка писем с локалхоста / basic smtp config
sed -i 's/  email_delivery:/  email_delivery:\n    delivery_method: :async_smtp\n    smtp_settings:\n      address: "localhost"\n      port: 25/' config/configuration.yml 
# Создаем конфигурацию для веб-сервера puma / Make puma web-server config
cat > /opt/redmine/puma_config.rb << EOL
#!/usr/bin/env puma
directory '/opt/redmine'
daemonize true
pidfile '/run/puma.pid'
stdout_redirect '/opt/redmine/log/log.out', '/opt/redmine/log/log.error', true
environment 'production'
bind 'tcp://0.0.0.0:80'
EOL

# Создаем systemd service-файл redmine для автозапуска / Make systemd service file for autostart redmine
cat > /etc/systemd/system/redmine.service << EOL
[Unit]
Description=Redmine on Puma web-server
After=network.target

[Service]
Type=forking
User=root
WorkingDirectory=/opt/redmine
PIDFile=/run/puma.pid
ExecStart=/usr/bin/bundle exec puma -C /opt/redmine/puma_config.rb
ExecStop=/bin/kill -9 $MAINPID
TimeoutSec=60

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload
systemctl enable redmine
systemctl start redmine
systemctl status redmine