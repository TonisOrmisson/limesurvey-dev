FROM ubuntu:xenial
RUN apt update
RUN apt install -y nginx
RUN apt install -y mysql-server
# first n is for validate password plugin removal and it could be y
RUN mysql_install_db
RUN mysql_secure_installation

# Expose Ports
EXPOSE 443
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]