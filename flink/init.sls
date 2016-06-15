include:
{% if grains.os_family in ['Debian', 'Ubuntu'] %}
    - flink.webupd8team
{% endif %}
    - flink.dependencies
    - flink.user
    - flink.binaries

