docker build --tag tonisormisson/limesurvey-dev .
docker tag tonisormisson/limesurvey-dev:latest tonisormisson/limesurvey-dev:3.18.0.0
docker push tonisormisson/limesurvey-dev

