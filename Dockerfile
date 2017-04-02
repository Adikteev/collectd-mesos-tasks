FROM alpine:3.1


RUN apk --update add make git collectd collectd-write_http collectd-python py-pip && \
    pip install envtpl

RUN cd /usr/share && ln -s collectd5 collectd

COPY ./collectd.conf.tpl /etc/collectd/collectd.conf.tpl
COPY ./mesos-tasks.py /usr/share/collectd/plugins/mesos/

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
