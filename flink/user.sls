{% from 'flink/map.jinja' import flink_settings with context %}

create_flink_user:
    user.present:
        - name: {{ flink_settings.env.user }}
        {% if flink_settings.env.groups is defined %}
        - groups:
            {% for group in flink_settings.env.groups %}
            - {{ group }}
            {% endfor %}
        {% endif %}
        - fullname: Flink User
        - shell: /bin/bash
        - empty_password: True

