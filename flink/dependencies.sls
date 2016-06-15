{% from 'flink/map.jinja' import dependencies with context %}

flink-dependencies:
    pkg.installed:
        - refresh: true
        - pkgs:
        {% for package in dependencies.packages %}
            - {{ package }}
        {% endfor %}

