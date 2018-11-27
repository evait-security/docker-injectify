# used Image is docker-specialised ubuntu
FROM phusion/baseimage

ENV GIT_APP_ID=000000
ENV GIT_APP_SECRET=0000000
ENV PORT=3000

EXPOSE ${PORT}

# Install all needed requirements
RUN /bin/sh -c    'apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"; \
curl -sL https://deb.nodesource.com/setup_8.x | bash - ; \
apt-get install --yes \
mongodb \
git \
gcc \
g++ \
make;\
apt-get install --yes \
nodejs; \
npm i -g yarn; \
yarn global add typescript; \
yarn global add pm2; \
git clone https://github.com/samdenty/injectify.git /Injectify; \
cd /Injectify; \
rm -rf /var/lib/apt/lists/*; '

# Autostart MongoDB
#Initialize My_Init_Folder first
RUN mkdir -p /etc/my_init.d
COPY mongod_start.sh /Injectify/mongod_start.sh

# Copy needed server.config.js and insert given ENV values
COPY server.config.js /Injectify/server.config.js
COPY env.sh /Injectify/env.sh

RUN /bin/sh -c 'chmod +x /Injectify/mongod_start.sh; \
chmod +x /Injectify/env.sh; '

#RUN /bin/bash -c "sed -i 's/MY_APP_ID/${GIT_APP_ID}/g' /Injectify/server.config.js; \
#sed -i 's/MY_APP_SECRET/${GIT_APP_SECRET}/g' /Injectify/server.config.js; \
#sed -i 's/express: 3000,/express: ${PORT},/g' /Injectify/server.config.js; "


# Building the finished tool
WORKDIR /Injectify
RUN /bin/sh -c 'cd /Injectify; yarn run install:all; '

CMD /Injectify/env.sh; /Injectify/mongod_start.sh; /usr/bin/yarn run deploy > /tmp/injectify.log; tail -f /tmp/injectify.log