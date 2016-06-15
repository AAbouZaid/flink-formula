include:
{% if grains.os_family == 'Debian' or grains.os_family == 'Ubuntu' %}
    - flink.webupd8team
{% endif %}
    - flink.dependencies
    - flink.user
    - flink.binaries
