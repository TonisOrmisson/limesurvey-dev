# limesurvey-xenial
A docker image build script for a limesurvey DEVELOPMEMT image. 

### NB! this image is not meant for running any production sites!

## Environment

- ubuntu 16.04
- nginx
- php 7.0
- mysql 5.7
- version tag matches LS version
- nginx does not cache files (css/js development)

The image includes a a mysql server with the user:root password:root.
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
docker run --name my-lime -p 8080:80 tonisormisson/limesurvey-dev-xenial
```

use a local LS code
```
docker run --name my-lime --net my-net -v /my/local/path:/var/www/html -p 8080:80 tonisormisson/limesurvey-dev-xenial
```
