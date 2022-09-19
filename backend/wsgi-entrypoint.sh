#!/bin/sh

cd /app/backend

python3 manage.py makemigrations
 
python3 manage.py migrate

python3 manage.py collectstatic --no-input

gunicorn realest_estate.wsgi:application --bind 0.0.0.0:8000 --workers 4 --threads 4
