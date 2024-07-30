FROM cirrusci/flutter

COPY . /app
WORKDIR /app

USER root

RUN rm -f .packages

RUN flutter pub get
RUN flutter clean
RUN flutter build apk

RUN mkdir /build_mobileapp/
RUN cp build/app/outputs/apk/release/app-release.apk /build_mobileapp/client.apk