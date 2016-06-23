{% from 'flink/map.jinja' import flink_settings with context %}

download_and_extract_flink_tarball:
    archive.extracted:
        - name: /opt/
        - if_missing: /opt/flink-{{ flink_settings.version }}
        - source: {{ flink_settings.binaries_base_url }}/flink/flink-{{ flink_settings.version }}/flink-{{ flink_settings.version }}-bin-hadoop{{ flink_settings.hadoop_version }}-scala_{{ flink_settings.scala_version }}.tgz
        - source_hash: {{ flink_settings.hash_base_url }}/dist/flink/flink-{{ flink_settings.version }}/flink-{{ flink_settings.version }}-bin-hadoop{{ flink_settings.hadoop_version }}-scala_{{ flink_settings.scala_version }}.tgz.sha
        - archive_format: tar
        - user: {{ flink_settings.env.user }}
        - group: {{ flink_settings.env.user }}

link_to_flink_binaries:
    file.symlink:
        - name: {{ flink_settings.env.home }}
        - target: /opt/flink-{{ flink_settings.version }}
        - user: {{ flink_settings.env.user }}
        - group: {{ flink_settings.env.user }}
