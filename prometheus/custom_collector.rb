class CustomColector < PrometheusExporter::Server::TypeCollector
  attr_reader :last_month_posts_gauge, :last_year_posts_gauge
  unless defined? Rails
    require File.expand_path("../../config/environment", __FILE__)
  end

  def initialize
    @last_month_posts_gauge = PrometheusExporter::Metric::Gauge.new('month', 'monthly posts')
    @last_year_posts_gauge = PrometheusExporter::Metric::Gauge.new('year', 'yearly posts')
  end

  def type
    'post'
  end

  def metrics
    monthly_posts = Article.where(published_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month).size
    yearly_posts = Article.where(published_at: DateTime.now.beginning_of_year..DateTime.now.end_of_year).size

    last_month_posts_gauge.observe(monthly_posts)
    last_year_posts_gauge.observe(yearly_posts)
    [last_month_posts_gauge, last_year_posts_gauge]
  end
end
