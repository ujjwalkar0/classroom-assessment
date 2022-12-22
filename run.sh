#!/bin/bash

# to stop on first error
set -e

for o in "$@" 
do
    if [ $o == "clear" ]
    then
        echo "removing old database..."
        rm core/store.sqlite3

        echo "creating new database..."
        flask db upgrade -d core/migrations/

    fi
done

echo "running server..."
# Delete older .pyc files
# find . -type d \( -name env -o -name venv  \) -prune -false -o -name "*.pyc" -exec rm -rf {} \;

# Run required migrations
export FLASK_APP=core/server.py

# flask db init -d core/migrations/
# flask db migrate -m "Initial migration." -d core/migrations/
# flask db upgrade -d core/migrations/

# Run server
gunicorn -c gunicorn_config.py core.server:app
