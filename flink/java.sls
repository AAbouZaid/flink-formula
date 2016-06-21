{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.java.update(salt['pillar.get']('flink:java', {})) %}

{% set curl_opts = '-b oraclelicense=accept-securebackup-cookie -L -s' %}
{% set tar_file = '/tmp/java.tar.gz' %}

download-tarball:
    cmd.run:
        - unless: curl {{ curl_opts }} -o "{{ tar_file }}" {{ flink.java.url }}

install-java:
    archive.extracted:
        - name: /opt/
        - if_missing: /opt/{{ flink.java.name }}
        - source: file://{{ tar_file }}
        - source_hash: {{ flink.java.hash }}
        - archive_format: tar

symlink-to-java:
    file.symlink:
        - name: {{ flink.java.home }}
        - target: /opt/{{ flink.java.name }}

add-to-profile:
    file.managed:
        - name: /etc/profile.d/sun-java.sh
        - source: salt://flink/files/sun-java.jinja
        - template: jinja
        - user: root
        - group: root
        - mode: 644
        - context:
            java_home: {{ flink.java.home }}
purge:
    file.absent:
        - name: {{ tar_file }}

