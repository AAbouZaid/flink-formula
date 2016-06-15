{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.update(salt['pillar.get']('flink', {})) %}

{% from 'flink/map.jinja' import dependencies with context %}

# TODO: packages' names according to distro
flink-purge:
    file.absent:
        - name: /opt/flink-{{ flink.version }}
    pkg.purged:
        - pkgs:
        {% for package in dependencies.packages %}
            - {{ package }}
        {% endfor %}
    user.absent:
        - name: flink
        - purge: true

