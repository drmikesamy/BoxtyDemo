#!/bin/bash
# Replace placeholder with actual environment value
BLAZOR_ENV=${BLAZOR_ENVIRONMENT:-Production}
sed -i "s/add_header Blazor-Environment \"Production\";/add_header Blazor-Environment \"$BLAZOR_ENV\";/" /etc/nginx/nginx.conf
# Start nginx
nginx -g "daemon off;"
