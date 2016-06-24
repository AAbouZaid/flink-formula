{% from 'flink/map.jinja' import flink_settings with context %}

{% if flink_settings.slaves is defined %}
add_flink_slaves:
    file.managed:
        - name: {{ flink_settings.env.conf }}/slaves
        - source: salt://flink/files/slaves.jinja
        - template: jinja
        - context:
            slaves: {{ flink_settings.slaves }}
{% for slave in flink_settings.slaves %}
{% if slave.ip_addr is defined %}
add_{{ slave.host_name }}_to_hosts_file:
    host.only:
        - name: {{ slave.ip_addr }}
        - hostnames: {{ slave.host_name }}
{% endif %}
{% endfor %}
{% endif %}

{% if flink_settings.conf is defined %}
configure_flink_jobmanager:
    file.managed:
        - name: {{ flink_settings.env.conf }}/flink-conf.yaml
        - source: salt://flink/files/flink-conf.jinja
        - template: jinja
        - context:
            flink_conf: {{ flink_settings.conf }}
{% endif %}
