{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.update(salt['pillar.get']('flink', {})) %}

# TODO: packages' names according to distro
flink-purge:
    file.absent:
        - name: /opt/flink-{{ flink.version }}
    pkg.purged:
        - pkgs:
            - default-jre-headless
            - openssh-server
    user.absent:
        - name: flink
        - purge: true

