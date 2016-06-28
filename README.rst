=============
flink-formula
=============

Formula to install and configure `Apache
Flink <https://flink.apache.org/>`__, an open source platform for
distributed stream and batch data processing.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.


Available states
================

.. contents::
    :local:

``flink.user``
--------------

It creates the ``flink`` user. The state can be modified via pillar as
follows

.. code:: yaml

    flink:
        env:
            groups:
                - root
                - users
        master:
            ssh:
                privkey: |
                    -----BEGIN RSA PRIVATE KEY-----
                    NOT_DEFINED
                    -----END RSA PRIVATE KEY-----
                pubkey: ssh-rsa AAAAB3NzaC1kc3MAAACBAL0sQ9fJ5bYTEyY== flink@flink-master

``flink.env.groups`` lists the groups where the ``flink`` user will be
member of.

``flink.master.ssh`` contains the SSH keypair.

``flink.java``
--------------

It installs Oracle Java Runtime Environment. The state can be modified
via pillar as follows

.. code:: yaml

    flink:
        java:
            url: 'http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jre-7u80-linux-i586.tar.gz'
            name: 'jre1.7.0_80'
            hash: 'md5=0811a4045714bd8f1e1577e318528597'
            home: '/alternative/java/home'

This state is inspired and can be substituted by
`sun-java-formula <https://github.com/saltstack-formulas/sun-java-formula>`__.

``flink.ssh``
-------------

It installs and run OpenSSH (client, server). For a more accurate
installation it is strongly suggested to substitute this state with
`openssh-formula <https://github.com/saltstack-formulas/openssh-formula>`__
from the SaltStack community.

``flink.binaries``
------------------

It installs the Flink's binaries. The state can be modified with pillar
as follows.

.. code:: yaml

    flink:
        version: 1.0.3
        hadoop_version: 27
        scala_version: 2.11
        binaries_base_url: http://mirror.nohup.it/apache
        hash_base_url: http://www-eu.apache.org

``version``, ``hadoop_version`` and ``scala_version`` are used to select
the Flink's version to be installed. More details on the `Flink's
download page <https://flink.apache.org/downloads.html>`__.

To enhance download performances, ``binary_base_url`` and
``hash_base_url`` should be set according to your location. For
instance, take a look
`here <http://www.apache.org/dyn/closer.lua/flink/flink-1.0.3/flink-1.0.3-bin-hadoop27-scala_2.11.tgz>`__.

``flink.jobmanager``
--------------------

It configures a Flink's jobmanager. The state can be modified with
pillar as follow.

.. code:: yaml

    flink:
        conf:
            jobmanager.heap.mb: 256
            jobmanager.rpc.address: localhost
            jobmanager.rpc.port: 6123
            jobmanager.web.port: 8081
            parallelism.default: 1
            taskmanager.heap.mb: 512
            taskmanager.memory.preallocate: false
            taskmanager.numberOfTaskSlots: 1
        slaves:
            - host_name: flink-slave-1
              ip_addr: 192.168.100.1
            - host_name: flink-slave-2
              ip_addr: 192.168.100.2
            - host_name: flink-slave-3
              ip_addr: 192.168.100.3

The full list of usable keys under ``flink.conf`` is listed on the
`Flink
Configuration <https://ci.apache.org/projects/flink/flink-docs-master/setup/config.html>`__
page. ``flink.conf`` is optional. Without defining it in pillar, Flink
will be installed with the default configuration.

Elements of the ``flink.slaves`` list represent the cluster's slave
nodes and they are used to fill ``$FLINK_HOME/conf/slaves``.
``flink.slaves`` is optional. Without defining it in pillar,
``$FLINK_HOME/conf/slaves`` will be leaved untouched.

Slave nodes can be defined as ``(host_name, ip_addr)`` or simply with
``host_name``. In the first case, an entry in ``/etc/hosts`` will be
added.

``flink.taskmanager``
---------------------

It configures a Flink's taskmanager. The state can be modified with
pillar as follows.

.. code:: yaml

    flink:
        conf:
            jobmanager.heap.mb: 256
            jobmanager.rpc.address: localhost
            jobmanager.rpc.port: 6123
            jobmanager.web.port: 8081
            parallelism.default: 1
            taskmanager.heap.mb: 512
            taskmanager.memory.preallocate: false
            taskmanager.numberOfTaskSlots: 1
        master:
            host_name: flink-master
            ip_addr: 192.168.100.254
            ssh:
                pubkey: ssh-rsa AAAAB3NzaC1kc3MAAACBAL0sQ9fJ5bYTEyY== flink@flink-master

About ``flink.conf`` you may refer to ``flink.jobmanager``
documentation.

``flink.master`` contains the information about the Flink's master node
to allow SSH connections. ``ip_addr`` is optional and if defined, an
entry in ``/etc/hosts`` is appended.

References
==========

-  `Apache Flink <https://flink.apache.org/>`__
-  `Salt
   Formulas <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`__
