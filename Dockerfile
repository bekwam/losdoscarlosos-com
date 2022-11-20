FROM node:latest

LABEL maintainer="Carl Walker <carl@bekwam.com>"

RUN apt-get update
RUN apt-get -y install nginx 

# gather source and compiled output here
WORKDIR /losdoscarlosos-com

# copy source to WORKDIR
COPY ./tailwind.config.js .
COPY ./src ./src
COPY ./public ./public

# compile src
RUN npm install -D tailwindcss
RUN npx tailwindcss -i ./src/css/styles.css -o ./public/css/styles.css

# move compiled product to ngnix html folder
RUN cp -r ./public/. /var/www/html

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
