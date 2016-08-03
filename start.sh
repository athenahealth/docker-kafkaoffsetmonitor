#!/bin/bash

OFFSET_STORAGE=${OFFSET_STORAGE:-zookeeper}
ZK_HOSTS=${ZK_HOSTS:-localhost:2181}
PORT=${PORT:-8080}
REFRESH_SECONDS=${REFRESH_SECONDS:-10}
RETAIN_DAYS=${RETAIN_DAYS:-2}

GRAPHITE_HOST=${GRAPHITE_HOST:-localhost}
GRAPHITE_PORT=${GRAPHITE_PORT:-2003}
GRAPHITE_PREFIX=${GRAPHITE_PREFIX:-stats.kafka.offset_monitor}
GRAPHITE_REPORT_PERIOD_SECONDS=${GRAPHITE_REPORT_PERIOD_SECONDS:-30}
METRICS_CACHE_EXPIRE_SECONDS=${METRICS_CACHE_EXPIRE_SECONDS:-600}

PLUGIN_ARGS=${PLUGIN_ARGS:-graphiteHost=${GRAPHITE_HOST},graphitePort=${GRAPHITE_PORT},graphitePrefix=${GRAPHITE_PREFIX},graphiteReportPeriod=${GRAPHITE_REPORT_PERIOD_SECONDS},metricsCacheExpireSeconds=${METRICS_CACHE_EXPIRE_SECONDS}}

exec java -cp "/cp/*" \
  com.quantifind.kafka.offsetapp.OffsetGetterWeb \
  --offsetStorage ${OFFSET_STORAGE} \
  --zk ${ZK_HOSTS} \
  --port ${PORT} \
  --refresh ${REFRESH_SECONDS}.seconds \
  --retain ${RETAIN_DAYS}.days \
  --pluginsArgs ${PLUGIN_ARGS}
