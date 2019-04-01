FROM sightmachine/simplecv
LABEL maintainer="Srini Karlekar <skarlekar@yahoo.com>"

RUN apt-get update && \
    apt-get install -y python-pip && \
    apt-get clean

RUN pip install  --upgrade pip
RUN pip install  Flask

WORKDIR /app
COPY app/app.py /app

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["app.py"]
