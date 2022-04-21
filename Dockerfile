FROM python:3.10.4-slim-bullseye
WORKDIR /rwdp
ENV FLASK_APP=/rwdp/main.py
# remove for production
ENV FLASK_ENV=development

RUN apt-get update  \
    && apt-get -y upgrade  \
    && apt-get -y autoremove \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*
RUN python -m pip install --upgrade pip setuptools wheel

COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

COPY rwdp/ .

EXPOSE 5000

CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
