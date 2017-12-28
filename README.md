# limesurvey-xenial
a docker image build script for a limesurvey DEVELOPMEMT image. 

## build the image

```
docker build  -t limesurvey-dev .
```


## run image

```
docker run --name my-lime -p 8080:80 limesurvey-dev
```
