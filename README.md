# limesurvey-xenial
A docker image build script for a limesurvey DEVELOPMEMT image. 

### NB! this image is not meant for running any production sites!

## Environment

- ubuntu 24.04
- nginx
- php 8.3
- Mariadb
- version tag matches LS version. The last bit of the version tag is for this docker versioning
- nginx does not cache files (css/js development)
- LimeSurvey Release 6.5.4+240422
- 
The image includes a MariaDb server with the user:root password:root.
And the test-installation of limeSurvey with the user:admin password:password similar to the LimeSurvey original Travis testing set-up.

## Tests

The image is ready for running the LS tests

Login to your running container
```
docker exec -it my-lime bash
```

Run tests
```
$ cd /var/www/html
$ DOMAIN=localhost phpunit
```


## Run image

With the included LS code
```
docker run --name my-lime -p 8080:80 tonisormisson/limesurvey-dev
```

use a local LS code
```
docker run --name my-lime --net my-net -v /my/local/path:/var/www/html -p 8080:80 tonisormisson/limesurvey-dev
```
