#! /bin/bash
sed -i 's/MY_APP_ID/'"$GIT_APP_ID"'/g' /Injectify/server.config.js
sed -i 's/MY_APP_SECRET/'"$GIT_APP_SECRET"'/g' /Injectify/server.config.js
sed -i 's/express: 3000,/express: '"$PORT"',/g' /Injectify/server.config.js