# frozen_string_literal: true

if Rails.env != "test"
  require 'prometheus_exporter/middleware'

  Rails.application.middleware.unshift PrometheusExporter::Middleware
end
