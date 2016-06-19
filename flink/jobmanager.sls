{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set jobmanager = default_settings.get('jobmanager') %}
{% do default_settings.jobmanager.update(salt['pillar.get']('jobmanager', {})) %}

{% if jobmanager.slaves is defined %}
add_slaves:
    file.managed:
        - name: {{ jobmanager.slaves_file }}
        - source: salt://flink/files/slaves.jinja
        - template: jinja
        - context:
            jobmanager: {{ jobmanager }}
{% endif %}

flink-conf:
    file.managed:
        - name: '/tmp/flink-conf.yaml'
        - source: salt://flink/files/flink-conf.jinja
        - template: jinja
