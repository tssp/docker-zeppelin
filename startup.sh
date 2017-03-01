#!/bin/bash

set -x

/opt/zeppelin-0.7.0-bin-all/bin/zeppelin-daemon.sh start
tail -f /opt/zeppelin-0.7.0-bin-all/logs/zeppelin--*log
