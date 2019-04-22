unless defined? Rails
  require File.expand_path("../../config/environment", __FILE__)
end

class CommentsPerArticleCollector < PrometheusExporter::Server::TypeCollector
  def type
    "comments_per_article"
  end

  def metrics
    gauge = PrometheusExporter::Metric::Gauge.new("comments_per_article",
                                                  "Average number of comments per article")
    comments_per_article =
      Article.joins(:comments)
             .select("round((count(comments.id) / count(articles.id))::decimal, 2) as avg")
             .to_a.first.avg

    gauge.observe comments_per_article
    [gauge]
  end
end
