## docker image for [KafkaOffsetMonitor](https://github.com/quantifind/KafkaOffsetMonitor)

Includes [kafka-offset-monitor-graphite](https://github.com/allegro/kafka-offset-monitor-graphite) plugin to publish metrics to graphite.

Override config with env.

    ZK_HOSTS=${ZK_HOSTS:-localhost:2181}
    PORT=${PORT:-8080}
    REFRESH_SECONDS=${REFRESH_SECONDS:-10}
    RETAIN_DAYS=${RETAIN_DAYS:-2}
    GRAPHITE_HOST=${GRAPHITE_HOST:-localhost}
    GRAPHITE_PORT=${GRAPHITE_PORT:-2003}
    GRAPHITE_PREFIX=${GRAPHITE_PREFIX:-stats.kafka.offset_monitor}
    PLUGIN_ARGS=${PLUGIN_ARGS:-graphiteHost=${GRAPHITE_HOST},graphitePort=${GRAPHITE_PORT},graphitePrefix=${GRAPHITE_PREFIX}}
