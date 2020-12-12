docker build --no-cache --tag tonisormisson/limesurvey-dev .
docker tag tonisormisson/limesurvey-dev:latest tonisormisson/limesurvey-dev:3.25.2.1
docker push tonisormisson/limesurvey-dev

