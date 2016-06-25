{% from 'flink/map.jinja' import flink_settings with context %}

{% if flink_settings.master is defined %}
allow_ssh_connection_from_master:
    ssh_auth.present:
        - user: flink
        - names:
            - {{ flink_settings.master.ssh.pubkey }}

{% if flink_settings.master.ip_addr is defined %}
add_{{ flink_settings.master.host_name }}_to_hosts_file:
    host.only:
        - name: {{ flink_settings.master.ip_addr }}
        - hostnames: {{ flink_settings.master.host_name }}
{% endif %}
{% endif %}

{% if flink_settings.conf is defined %}
configure_flink_taskmanager:
    file.managed:
        - name: {{ flink_settings.env.conf }}/flink-conf.yaml
        - source: salt://flink/files/flink-conf.jinja
        - template: jinja
        - context:
            flink_conf: {{ flink_settings.conf }}
{% endif %}
