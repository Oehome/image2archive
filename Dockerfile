FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common
RUN add-apt-repository universe
RUN apt-get update && apt-get install -y \
    curl \
    python \
    python3-pip \
    exiftool


COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt



RUN mkdir /import \
    && mkdir /export  

WORKDIR /usr/local/scripts

ADD pic2archive.sh /bin/pic2archive.sh
ADD mqtt.py /bin/mqtt.py

CMD ["/bin/mqtt.py"]
ENTRYPOINT ["python3"]




