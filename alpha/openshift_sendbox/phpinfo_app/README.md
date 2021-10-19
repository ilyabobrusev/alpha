# phpinfo
Test fot openshift_sendbox
# openshift deploy
oc new-app centos/php-73-centos7~https://github.com/ilyabobrusev/phpinfo.git --name phpinfo
oc expose svc/phpinfo