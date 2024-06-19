#!/usr/bin/env bash

# $1 user
# $2 folder
set_shared_permissions()
{
  	printf "For files in folder %s give permission to write for users %s and www-data\n" "$2" "$1"
    setfacl -Rm u:www-data:rwX,u:"$1":rwX "$2"

    printf "For all future files in folder %s give permission to write for users %s и www-data\n" "$2" "$1"
    setfacl -Rdm u:www-data:rwx,u:"$1":rwx "$2"
}

set -e

printf "Make owner of project user %s\n" "$1"
chown -R "$1:$1" ./

printf "Only user %s can write in project\n" "$1"
find /var/www/back -type f -exec chmod 644 {} \;
find /var/www/back -type d -exec chmod 755 {} \;

set_shared_permissions "$1" "/var/www/back/bootstrap/cache"
set_shared_permissions "$1" "/var/www/back/storage"

printf "Only user %s can write in passport files\n" "$1"
chmod 644 /var/www/back/storage/oauth-private.key
chmod 644 /var/www/back/storage/oauth-public.key

printf "Execute files in /vendor/bin/ dir\n"
chmod u+x /var/www/back/vendor/bin/*
