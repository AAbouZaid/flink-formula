{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.update(salt['pillar.get']('flink', {})) %}
{% set flink_conf = default_settings.get('flink_conf') %}
{% do default_settings.flink_conf.update(salt['pillar.get']('flink_conf', {})) %}

{% if flink.masters is defined %}
add_flink_masters:
    file.managed:
        - name: '{{ flink.conf }}/masters'
        - source: salt://flink/files/masters.jinja
        - template: jinja
        - context:
            masters: {{ flink.masters }}

{% for master in flink.masters %}
{% if master.ip_addr is defined %}
add_{{ master.host_name }}_to_hosts_file:
    host.only:
        - name: {{ master.ip_addr }}
        - hostnames: {{ master.host_name }}
{% endif %}
{% endfor %}
{% endif %}

{% if flink.slaves is defined %}
add_flink_slaves:
    file.managed:
        - name: '{{ flink.conf }}/slaves'
        - source: salt://flink/files/slaves.jinja
        - template: jinja
        - context:
            slaves: {{ flink.slaves }}

{% for slave in flink.slaves %}
{% if slave.ip_addr is defined %}
add_{{ slave.host_name }}_to_hosts_file:
    host.only:
        - name: {{ slave.ip_addr }}
        - hostnames: {{ slave.host_name }}
{% endif %}
{% endfor %}
{% endif %}

configure_flink:
    file.managed:
        - name: '{{ flink.conf}}/flink-conf.yaml'
        - source: salt://flink/files/flink-conf.jinja
        - template: jinja
        - context:
            flink_conf: {{ flink_conf }}

