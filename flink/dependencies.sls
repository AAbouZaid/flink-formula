{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.update(salt['pillar.get']('flink', {})) %}

# TODO: packages' names according to distro
flink-dependencies:
    pkg.installed:
        - refresh: true
        - pkgs:
            - default-jre-headless
            - openssh-server

