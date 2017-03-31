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
    ModulePath "/opt/collectd-librato-0.0.10/lib"

    Import "collectd-librato"
    <Module "collectd-librato">
        Email    "{{ LIBRATO_EMAIL_ADDRESS }}"
        APIToken "{{ LIBRATO_API_TOKEN }}"
    </Module>

    ModulePath "/usr/share/collectd/plugins/mesos"

    Import "mesos-tasks"
    <Module "mesos-tasks">
        Host "{{ MESOS_HOST }}"
        Port {{ MESOS_PORT | default(5051) }}
    </Module>
</Plugin>
