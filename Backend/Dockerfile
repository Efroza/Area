FROM python:3.11.0

RUN apt-get update


COPY . .

RUN pip install -r requirements.txt

RUN rm -f .env

EXPOSE 8000