web: bundle exec rails server -p 3000 -e local_production
worker: bundle exec rake jobs:work
prometheus: bundle exec prometheus_exporter
