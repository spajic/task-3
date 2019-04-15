# config/initializers/prometheus.rb
# http://localhost:9394/metrics - to see raw metrics
unless Rails.env.test?
  require "prometheus_exporter/middleware"

  # This reports stats per request like HTTP status and timings
  Rails.application.middleware.unshift PrometheusExporter::Middleware
end
