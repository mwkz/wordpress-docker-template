#!/bin/bash

if [ -z "$1" ]
  then
    echo "Please provide site name. e.g. init.sh sitename com"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "Please provide site domain without the dot. e.g. init.sh sitename com"
    exit 1
fi


read -p "This will bootstrap the development environment. Are you sure to continue? (y|n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi



mkdir ../db
mkdir ../wordpress
mkdir ../config

echo APP_ID=$1.$2 > ../.env
echo DB_PASSWORD=20042005 >> ../.env
echo DB_USER=$1_$2   >> ../.env
echo DB_PORT=3306 >> ../.env
echo DB_NAME=$1_$2   >> ../.env 


cp docker-compose.yml ..
cp Dockerfile ..
cp reset-perms.sh ..

cp docker/* ../config/ -R


# generate a development SSL certificate
cd ../config/apache2/conf/ssl
openssl genrsa -des3 -passout pass:foobar -out wpdocker.local.pem 2048
openssl req -passin pass:foobar -new -sha256 -key wpdocker.local.pem -subj "/C=US/ST=CA/O=$1, Inc./CN=localhost" -reqexts SAN -config <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nsubjectAltName=DNS:$1.$2,DNS:www.$1.$2")) -out wpdocker.local.csr
openssl x509 -passin pass:foobar -req -days 365 -in wpdocker.local.csr -signkey wpdocker.local.pem -out wpdocker.local.crt
openssl rsa -passin pass:foobar -in wpdocker.local.pem -out wpdocker.local.key

 