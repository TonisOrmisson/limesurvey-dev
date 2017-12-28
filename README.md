# limesurvey-xenial
A docker image build script for a limesurvey DEVELOPMEMT image. 

### NB! this image is not meant for running any production sites!

## build the image

```
docker build  -t tonisormisson/limesurvey-dev-xenial:0.1.0 ..
```


## run image

```
docker run --name my-lime -p 8080:80 tonisormisson/limesurvey-dev-xenial
```


