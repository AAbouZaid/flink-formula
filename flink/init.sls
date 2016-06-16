include:
{% if grains.os in ['Debian', 'Ubuntu'] %}
    - flink.java_sun_deb
{% elif grains.os in ['CentOS', 'RedHat']%}
    - flink.java_sun_rpm
{% endif %}
    - flink.dependencies
    - flink.user
    - flink.binaries

