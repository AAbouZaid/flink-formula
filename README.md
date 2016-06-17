# flink-formula

Formula to install and configure [Apache Flink](https://flink.apache.org/),
an open source platform for distributed stream and batch data processing.

## Available states

The formula includes the following states:

* [`flink.user`](./flink/user.sls)
* [`flink.java`](./flink/java.sls)
* [`flink.ssh`](./flink/ssh.sls)
* [`flink.binaries`](./flink/binaries.sls)
* [`flink.jobmanager`](./flink/jobmanager.sls)
* [`flink.taskmanager`](./flink/taskmanager.sls)

### [`flink.user`](./flink/user.sls)

It creates the `flink` user.

### [`flink.java`](./flink/java.sls)

It installs Oracle Java 8.
The state can be modified via pillars.

### [`flink.ssh`](./flink/ssh.sls)

> To be finalised

It installs and configures OpenSSH as Flink likes.

### [`flink.binaries`](./flink/binaries.sls)

It installs the Flink's binaries.
The state can be modified via pillars.

### [`flink.jobmanager`](./flink/jobmanager.sls)

> To be implemented

It configures a Flink's jobmanager.
The state can be modified via pillars.

### [`flink.taskmanager`](./flink/taskmanager.sls)

> To be implemented

It configures a Flink's taskmanager.
The state can be modified via pillars.

## References

* [Apache Flink](https://flink.apache.org/)
* [Salt Formulas](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html)

