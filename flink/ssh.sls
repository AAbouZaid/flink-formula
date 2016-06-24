{% from 'flink/map.jinja' import flink_settings with context %}

install_openssh:
    pkg.installed:
        - refresh: true
        - pkgs:
        {% for pkg in flink_settings.openssh.pkgs %}
            - {{ pkg }}
        {% endfor %}

run_and_enable_openssh_daemon:
    service.running:
        - name: {{ flink_settings.openssh.service }}
        - enable: True
