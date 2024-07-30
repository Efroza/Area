FROM node:16.17.1-alpine

WORKDIR /web-front

COPY ./ ./

RUN npm install

# CMD npm start

RUN rm -f .env

RUN mkdir -p /build_mobileapp/
RUN ln -s /build_mobileapp/client.apk public/client.apk

EXPOSE 3000

CMD sh -c "npm install && npm start"