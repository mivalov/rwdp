FROM python:3.10.6-slim-bullseye

WORKDIR /rwdp

# important when 'flask run' is called
# ENV FLASK_APP=/rwdp/main.py
# remove for production
ENV FLASK_ENV=development

RUN apt-get update  \
    && apt-get -y upgrade  \
    && apt-get -y autoremove \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*
RUN python -m pip install --upgrade --no-cache-dir pip setuptools wheel

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY rwdp/ .

EXPOSE 5000

#CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
CMD ["waitress-serve", "--host=0.0.0.0", "--port=5000", "main:app"]
