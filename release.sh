docker build --tag tonisormisson/limesurvey-dev .
docker tag tonisormisson/limesurvey-dev:latest tonisormisson/limesurvey-dev:3.28.58
docker push tonisormisson/limesurvey-dev --all-tags

