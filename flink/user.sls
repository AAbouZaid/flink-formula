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

{% if flink_settings.master.ssh is defined
    and flink_settings.master.ssh.privkey is defined %}
create_ssh_dir:
    file.directory:
        - name: /home/{{ flink_settings.env.user }}/.ssh
        - user: {{ flink_settings.env.user }}
        - group: {{ flink_settings.env.group }}
        - mode: 700

add_ssh_priv_key:
    file.managed:
        - name: /home/{{ flink_settings.env.user }}/.ssh/id_rsa
        - contents_pillar: 'flink:master:ssh:privkey'
        - user: {{ flink_settings.env.user }}
        - group: {{ flink_settings.env.group }}
        - mode: 600
        - require:
            - file: create_ssh_dir

add_ssh_pub_key:
    file.managed:
        - name: /home/{{ flink_settings.env.user }}/.ssh/id_rsa.pub
        - contents_pillar: 'flink:master:ssh:pubkey'
        - user: {{ flink_settings.env.user }}
        - group: {{ flink_settings.env.group }}
        - mode: 600
        - require:
            - file: create_ssh_dir
{% endif %}
