{% from 'flink/map.jinja' import flink_settings with context %}

{% set curl_opts = '-b oraclelicense=accept-securebackup-cookie -L -s' %}
{% set tar_file = '/tmp/java.tar.gz' %}

download_jre_tarball:
    cmd.run:
        - unless: curl {{ curl_opts }} -o "{{ tar_file }}" {{ flink_settings.java.url }}

extract_jre_tarball:
    archive.extracted:
        - name: /opt/
        - if_missing: /opt/{{ flink_settings.java.name }}
        - source: file://{{ tar_file }}
        - source_hash: {{ flink_settings.java.hash }}
        - archive_format: tar

symlink_to_java_home:
    file.symlink:
        - name: {{ flink_settings.java.home }}
        - target: /opt/{{ flink_settings.java.name }}

set_java_home_env:
    file.managed:
        - name: /etc/profile.d/sun-java.sh
        - source: salt://flink/files/sun-java.jinja
        - template: jinja
        - user: root
        - group: root
        - mode: 644
        - context:
            java_home: {{ flink_settings.java.home }}
