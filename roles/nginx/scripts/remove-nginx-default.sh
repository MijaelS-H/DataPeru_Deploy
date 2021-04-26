#!/bin/bash -eux

# Delete the default nginx config
if [ -L "/etc/nginx/sites-enabled/default" ]; then
    rm /etc/nginx/sites-enabled/default
fi

if [ -f "/etc/nginx/sites-available/default" ]; then
    rm /etc/nginx/sites-available/default
fi