{% set rpm = 'jre-8u92-linux-x64.rpm' %}
{% set url = 'http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jre-8u92-linux-x64.rpm' %}
{% set curl_opts = '-b oraclelicense=accept-securebackup-cookie -L -s' %}

java_sun_rpm:
    cmd.run:
        - unless: curl {{ curl_opts }} -o "/tmp/{{ rpm }}" "{{ url }}"
    pkg.installed:
        - soruces:
            - jre1.8.0_92: /tmp/{{ rpm }}
    file.absent:
        - name: /tmp/{{ rpm }}

