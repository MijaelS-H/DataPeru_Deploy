
# Clickhouse
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E0C56BD4

# add repository
echo "deb http://repo.yandex.ru/clickhouse/deb/stable/ main/" | sudo tee /etc/apt/sources.list.d/clickhouse.list
sudo apt-get update

# install clickhouse
sudo apt-get install -y clickhouse-server clickhouse-client

# service start and check status
sudo service clickhouse-server start
sudo service clickhouse-server status


# Tesseract

wget https://github.com/tesseract-olap/tesseract/releases/latest/download/tesseract-olap.deb
dpkg -i tesseract-olap.deb

# service
sudo systemctl start tesseract-olap