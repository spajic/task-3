class TestMetrics < Influxer::Metrics
  set_series :test

  tags :user

  attributes :run_time_seconds, :samples

  validates :user, :run_time_seconds, :samples, presence: true
  validates :run_time_seconds, :samples, numericality: true
end
