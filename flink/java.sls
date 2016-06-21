{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.java.update(salt['pillar.get']('flink:java', {})) %}

{% set curl_opts = '-b oraclelicense=accept-securebackup-cookie -L -s' %}
{% set tar_file = '/tmp/java.tar.gz' %}

download_jre_tarball:
    cmd.run:
        - unless: curl {{ curl_opts }} -o "{{ tar_file }}" {{ flink.java.url }}

extract_jre_tarball:
    archive.extracted:
        - name: /opt/
        - if_missing: /opt/{{ flink.java.name }}
        - source: file://{{ tar_file }}
        - source_hash: {{ flink.java.hash }}
        - archive_format: tar

symlink_to_java_home:
    file.symlink:
        - name: {{ flink.java.home }}
        - target: /opt/{{ flink.java.name }}

set_java_home_env:
    file.managed:
        - name: /etc/profile.d/sun-java.sh
        - source: salt://flink/files/sun-java.jinja
        - template: jinja
        - user: root
        - group: root
        - mode: 644
        - context:
            java_home: {{ flink.java.home }}

remove_jre_tarball:
    file.absent:
        - name: {{ tar_file }}

