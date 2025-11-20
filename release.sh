docker build --tag tonisormisson/limesurvey-dev .
docker tag tonisormisson/limesurvey-dev:latest tonisormisson/limesurvey-dev:6.15.24
docker push tonisormisson/limesurvey-dev --all-tags

