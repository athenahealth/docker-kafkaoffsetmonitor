FROM java:jre-alpine

MAINTAINER Stas Alekseev

ENV SBT_VERSION 0.13.8
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV \
  KOM_CHECKOUT=0af627da8ab88dd4613e5e631f17472763d61199 \
  KOMG_CHECKOUT=b5a96c64cabb855cf0723e0cb2dde41fa677fbf0

RUN apk add --update curl git bash && \
  curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
  git clone https://github.com/VictorZeng/KafkaOffsetMonitor.git /tmp/kafkaoffsetmonitor && \
  cd /tmp/kafkaoffsetmonitor && \
  git checkout ${KOM_CHECKOUT} && \
  sbt publishM2 && \
  mkdir /cp && \
  cp target/scala-*/*.jar /cp && \
  git clone https://github.com/allegro/kafka-offset-monitor-graphite.git /tmp/kafkaoffsetmonitorgraphite && \
  cd /tmp/kafkaoffsetmonitorgraphite && \
  git checkout ${KOMG_CHECKOUT} && \
  sbt "set test in Test := {}" assembly && \
  cp target/scala-*/*.jar /cp && \
  apk del expat pcre git curl && \
  rm -rf /var/cache/apk/* /root/.m2 /root/.sbt /root/.ivy2 /tmp/* /usr/local/sbt

EXPOSE 8080

COPY start.sh /start.sh

CMD ["/start.sh"]
