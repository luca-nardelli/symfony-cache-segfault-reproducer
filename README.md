# symfony-cache-segfault-reproducer
Repository to demonstrate bug https://github.com/symfony/symfony/issues/36328

## How to reproduce

* Clone repository
* Run composer install
* cd into docker 
* Run `docker-compose build`
* Run `docker-compose up`
* Open a browser and navigate to http://localhost:8080, you should see a JSON output from MainController
* Navigate to http://localhost:8080/cache, if OPCACHE_USE_PRELOAD is 'true' in the docker-compose.yml environment section, you will get an error, otherwise it will work.
