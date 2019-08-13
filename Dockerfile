FROM ruby:latest as plugin-repo
RUN git clone https://github.com/jalxes/logstash-output-rollbar.git && \
    gem build logstash-output-rollbar/logstash-output-rollbar.gemspec

FROM logstash:7.3.0
ADD pipeline/ /usr/share/logstash/pipeline/
COPY --from=plugin-repo logstash-output-rollbar/logstash-output-rollbar-0.2.0.gem /usr/share/logstash/logstash-output-rollbar-0.2.0.gem
RUN bin/logstash-plugin install logstash-output-rollbar-0.2.0.gem
