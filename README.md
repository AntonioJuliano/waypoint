# Waypoint

Open source cryptocurrency wallet backend.

## Setup

* Install docker, start `docker-machine`
* `docker-compose up`
* `docker-compose run web db:migrate`

Make API requests to docker ip (`docker-machine ip default`) port `3000`. Ex: 192.168.99.100:3000/users
