{% import_yaml 'flink/defaults.yaml' as default_settings %}
{% set flink = default_settings.get('flink') %}
{% do default_settings.flink.update(salt['pillar.get']('flink', {})) %}

download_and_extract_flink_tarball:
    archive.extracted:
        - name: /opt/
        - if_missing: /opt/flink-{{ flink.version }}
        - source: http://mirror.nohup.it/apache/flink/flink-{{ flink.version }}/flink-{{ flink.version }}-bin-hadoop{{ flink.hadoop_version }}-scala_{{ flink.scala_version }}.tgz
        - source_hash: http://www-eu.apache.org/dist/flink/flink-{{ flink.version }}/flink-{{ flink.version }}-bin-hadoop{{ flink.hadoop_version }}-scala_{{ flink.scala_version }}.tgz.sha
        - archive_format: tar
        - user: {{ flink.user }}
        - group: {{ flink.group }}

link_to_flink_binaries:
    file.symlink:
        - name: {{ flink.home }}
        - target: /opt/flink-{{ flink.version }}
        - user: {{ flink.user }}
        - group: {{ flink.group }}

