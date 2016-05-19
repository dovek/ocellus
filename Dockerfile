FROM ubuntu:14.04

MAINTAINER Kyle Dove <dovek@umich.edu>

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install dependencies
RUN apt-get update && \
apt-get dist-upgrade -y && \
apt-get install -y libmysqlclient-dev git python-pip python-dev apache2 apache2-utils libldap2-dev libsasl2-dev nodejs curl

# Install Ocellus
WORKDIR /usr/local/

RUN git clone https://github.com/tl-its-umich-edu/ocellus.git

WORKDIR /usr/local/ocellus/

# Install python components based on ocellus requirements file
RUN pip install coverage
RUN pip install -r requirements.txt

#Node.js stuff
RUN curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash -
RUN apt-get install --yes nodejs
RUN npm install --global npm@latest
RUN npm install --global bower

RUN echo '{ "allow_root": true }' > /root/.bowerrc
RUN cd /usr/local/ocellus/mbofui/ && bower install
RUN cd /usr/local/ocellus/mbofui/ && bower install ui-leaflet

EXPOSE 8000

# copy settings file and launch django
CMD cp /usr/share/ocellus/settings.py /usr/local/ocellus/hacks_mbof/; python manage.py migrate;/usr/local/ocellus/runAsUser.sh bjensen