# limesurvey-xenial
A docker image build script for a limesurvey DEVELOPMEMT image. 

### NB! this image is not meant for running any production sites!

## Environment

- ubuntu 16.04
- nginx
- php 7.0
- mysql 5.7

The image includes a a mysql server with the user:root password:root.
And the test-installation of limeSurvey with the user:admin password:password similar to the LimeSurvey original Travis testing set-up.


## run image

```
docker run --name my-lime -p 8080:80 tonisormisson/limesurvey-dev-xenial
```

