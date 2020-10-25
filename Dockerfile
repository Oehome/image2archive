FROM alpine:latest
MAINTAINER OlliP <oliver@porrmann.de>

RUN apk --update add exiftool \
    && rm -rf /var/cache/apk/*

RUN mkdir /import \
    && mkdir /export  

WORKDIR /usr/local/scripts

ADD moveImagesFromImportToArchive.sh /bin/moveImagesFromImportToArchive.sh

ENTRYPOINT ["/bin/moveImagesFromImportToArchive.sh"]

