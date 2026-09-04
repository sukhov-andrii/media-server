# CVAT

## Installation

git clone https://github.com/cvat-ai/cvat.git
cd cvat

docker compose pull

docker compose -f docker-compose.yml up -d

After containers are up:

docker compose exec cvat_server bash -ic "python manage.py createsuperuser"

Then:

docker compose exec cvat_server bash -ic "python manage.py migrate"

Sometimes migration already runs automatically, but don’t trust automation blindly.

## Access

http://localhost:8080

## Created user
admin
email
password (possibly double input)