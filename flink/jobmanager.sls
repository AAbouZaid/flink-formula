{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.update(salt['pillar.get']('flink', {})) %}
{% set java = default_settings.get('java') %}
{% do default_settings.java.update(salt['pillar.get']('java', {})) %}

{% if flink.masters is defined %}
add_flink_masters:
    file.managed:
        - name: '{{ flink.conf }}/masters'
        - source: salt://flink/files/masters.jinja
        - template: jinja
        - context:
            masters: {{ flink.masters }}

{% for master in flink.masters %}
add_{{ master.host_name }}_to_hosts_file:
    host.only:
        - name: {{ master.ip_addr }}
        - hostnames: {{ master.host_name }}
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
add_{{ slave.host_name }}_to_hosts_file:
    host.only:
        - name: {{ slave.ip_addr }}
        - hostnames: {{ slave.host_name }}
{% endfor %}
{% endif %}

configure_flink:
    file.managed:
        - name: '{{ flink.conf}}/flink-conf.yaml'
        - source: salt://flink/files/flink-conf.jinja
        - template: jinja
        - context:
            settings: {{ flink.settings }}
            java: {{ java }}

