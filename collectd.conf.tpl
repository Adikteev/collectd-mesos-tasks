Hostname "{{ COLLECTD_HOST | default(MESOS_HOST) }}"

FQDNLookup false
Interval {{ COLLECTD_INTERVAL | default(10) }}
Timeout 2
ReadThreads 5

LoadPlugin write_graphite
<Plugin "write_graphite">
    <Carbon>
        Host "{{ GRAPHITE_HOST }}"
        Port "{{ GRAPHITE_PORT | default("2003") }}"
        Protocol "tcp"
        Prefix "{{ GRAPHITE_PREFIX | default("collectd.") }}"
        EscapeCharacter "."
        StoreRates true
        AlwaysAppendDS false
        SeparateInstances true
    </Carbon>
</Plugin>

<LoadPlugin "python">
    Globals true
</LoadPlugin>

<Plugin "python">
    ModulePath "/usr/share/collectd/plugins/mesos"

    Import "mesos-tasks"
    <Module "mesos-tasks">
        Host "{{ MESOS_HOST }}"
        Port {{ MESOS_PORT | default(5051) }}
    </Module>
</Plugin>

LoadPlugin write_http
<Plugin write_http>
  <Node "librato">
    URL "https://collectd.librato.com/v1/measurements"
    Format "JSON"
    BufferSize 8192

    User "{{ LIBRATO_EMAIL_ADDRESS }}"
    Password "{{ LIBRATO_API_TOKEN }}"
  </Node>
</Plugin>
