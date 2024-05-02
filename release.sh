docker build --tag tonisormisson/limesurvey-dev .
docker tag tonisormisson/limesurvey-dev:latest tonisormisson/limesurvey-dev:6.5.4
docker push tonisormisson/limesurvey-dev --all-tags

