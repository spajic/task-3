class TestMetrics < Influxer::Metrics
  set_series :test

  attributes :run_time_seconds
end
