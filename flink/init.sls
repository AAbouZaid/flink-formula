include:
{% if grains.os_family in ['Debian', 'Ubuntu'] %}
    - flink.java_sun_deb
{% elif grains.os_family in ['CentOS', 'RedHat']%}
    - flink.java_sun_rpm
{% endif %}
    - flink.dependencies
    - flink.user
    - flink.binaries

