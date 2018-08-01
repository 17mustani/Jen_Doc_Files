FROM ubuntu:16.04
LABEL maintainer='DevOps Specialist' \
      employee_name='Gopi Mustani' \
      version= 1.0.0
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN apt-get install wget -y
RUN apt-get install unzip -y

WORKDIR /tmp

RUN wget http://github.com/gopimustani/archive/master.zip

RUN unzip master.zip

# Apache server deployment directory is /var/www/html/

RUN mv -r ansible-role-java/* /var/www/html/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
