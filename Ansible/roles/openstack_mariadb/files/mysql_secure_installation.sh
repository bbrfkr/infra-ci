#!/bin/sh

ROOT_PASS=$1

expect -c "
set timeout 5

spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"\\r\"

expect \"Set root password?\"
send \"y\\r\"

expect \"New password:\"
send \"$ROOT_PASS\\r\"

expect \"Re-enter new password:\"
send \"$ROOT_PASS\\r\"

expect \"Remove anonymous users?\"
send \"y\\r\"

expect \"Disallow root login remotely?\"
send \"y\\r\"

expect \"Remove test database and access to it?\"
send \"y\\r\"

expect \"Reload privilege tables now?\"
send \"y\\r\"

expect EOF
exit 0
"

