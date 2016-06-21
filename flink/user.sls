{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.update(salt['pillar.get']('flink', {})) %}

create_flink_user:
    user.present:
        - name: {{ flink.user }}
        - fullname: Flink User
        - shell: /bin/bash

