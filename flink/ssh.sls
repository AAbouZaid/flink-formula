{% from 'flink/map.jinja' import ssh with context %}

install-ssh:
    pkg.installed:
        - refresh: true
        - pkgs:
        {% for package in ssh.packages %}
            - {{ package }}
        {% endfor %}

configure-ssh:
    cmd.run:
        - unless: echo "Soon available..."

run-ssh-server:
    service.running:
        - name: {{ ssh.service }}
        - enable: True

