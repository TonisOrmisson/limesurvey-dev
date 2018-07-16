docker build --tag tonisormisson/limesurvey-dev .
docker tag tonisormisson/limesurvey-dev:latest tonisormisson/limesurvey-dev-xenial:3.12.2.0
docker push tonisormisson/limesurvey-dev