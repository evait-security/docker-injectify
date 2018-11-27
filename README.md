# docker-injectify

## Description
This image allows to run [Injectify](https://github.com/samdenty/injectify) by samdenty localy inside of a docker container with a local database.

Injectify is a web based MiTM tool, similiar to BeEF (although completely unrelated in terms of source code). It uses modern web technologies such as ReactJS, Redux, Typescript and Webpack.

----------------------------------------

[github.com/evait-security/docker-injectify]( https://github.com/evait-security/docker-injectify)


# Build

git clone https://github.com/evait-security/docker-injectify

cd docker-injectify

docker build -t injectify .

# Instructions

## Requirements

To use Injectify properly, you first need to [register a new OAuth-Application](https://github.com/settings/applications/new) in Github. In the field ** *Authorization callback URL* ** you need to input your url **(with http)** where the finished Injectify-Website will be available , *e.g http://192.168.0.53:3000*. All other fields in the form can be choosen freely.

*Note: The default port of Injectify is 3000 but can be changed at startup*

## Run the container
```bash
docker run -d --name Injectify -e GIT_APP_ID=<your-app-id> -e GIT_APP_SECRET=<your-app-secret> evait/injectify:latest

```

## Advanced usage
To change the port to listen to, you can change the *PORT*-Enviroment variable
```bash
docker run -d --name Injectify -p <desired-port>:<desired-port> -e PORT=<desired-port> -e GIT_APP_ID=<your-app-id> -e GIT_APP_SECRET=<your-app-secret> evait/injectify:latest
```