{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set jobmanager = default_settings.get('jobmanager') %}
{% do default_settings.jobmanager.update(salt['pillar.get']('jobmanager', {})) %}

{% if jobmanager.slaves is defined %}
clean_slaves_file:
    cmd.run:
        - name: cat /dev/null > {{ jobmanager.slaves_file }}

add_slaves:
    file.append:
        - name: {{ jobmanager.slaves_file }}
        - text:
        {% for slave in jobmanager.slaves %}
            - {{ slave }}
        {% endfor %}
{% endif %}
