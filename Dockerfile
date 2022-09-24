FROM ghcr.io/linuxserver/baseimage-alpine:3.15
LABEL maintainer="SushiBox <info@sushibox.io>"

# Inform app this is a docker env
ENV MULTITAUTULLI_DOCKER=True

RUN apk update
RUN \
 echo "**** install build packages ****" && \
 apk --quiet --no-progress add ca-certificates curl bash python3 py3-pip python3-dev gcc libc-dev git tar bc findutils coreutils libffi-dev


RUN python3 -m pip install --no-cache --upgrade pip 
RUN pip3 install cffi pytz
RUN python3 -m pip install --upgrade pip setuptools pip-tools 
RUN pip3 install --ignore-installed  -r https://raw.githubusercontent.com/pazport/Tautullix2/main/requirements.txt

# ports and volumes
COPY root/ /
VOLUME /config
EXPOSE 8181
#CMD [ "sleep", "10000" ]
ENTRYPOINT [ "/init" ]
HEALTHCHECK --start-period=90s CMD curl -ILfSs http://localhost:8181 > /dev/null || curl -ILfkSs https://localhost:8181 > /dev/null || exit 1