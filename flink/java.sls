{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set java = default_settings.get('java') %}
{% do default_settings.java.update(salt['pillar.get']('java', {})) %}

{% set curl_opts = '-b oraclelicense=accept-securebackup-cookie -L -s' %}
{% set tar_file = '/tmp/java.tar.gz' %}

download-tarball:
    cmd.run:
        - unless: curl {{ curl_opts }} -o "{{ tar_file }}" {{ java.url }}

install-java:
    archive.extracted:
        - name: /opt/
        - if_missing: /opt/{{ java.name }}
        - source: file://{{ tar_file }}
        - source_hash: {{ java.hash }}
        - archive_format: tar
    file.symlink:
        - name: /opt/java
        - target: /opt/{{ java.name }}

purge:
    file.absent:
        - name: {{ tar_file }}

