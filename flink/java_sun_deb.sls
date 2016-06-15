# Ref: http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html
java_sun_deb:
    pkg.installed:
        - pkgs:
            - debconf
            - apt-utils
    pkgrepo.managed:
        - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main
        - humanname: Oracle Java Repository
        - keyid: EEA14886
        - keyserver: hkp://keyserver.ubuntu.com:80
        - refresh_db: true
    cmd.run:
        - unless: echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

