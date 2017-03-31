FROM alpine:3.1


RUN apk --update add make git collectd collectd-python py-pip && \
    pip install envtpl

RUN git clone git://github.com/librato/collectd-librato.git && cd collectd-librato && make install

RUN cd /usr/share && ln -s collectd5 collectd

COPY ./collectd.conf.tpl /etc/collectd/collectd.conf.tpl
COPY ./mesos-tasks.py /usr/share/collectd/plugins/mesos/

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
