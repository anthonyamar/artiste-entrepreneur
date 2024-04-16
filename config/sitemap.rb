# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://artiste-entrepreneur.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # STATIC PAGES
  add root_path, priority: 0.8
  add legal_path, priority: 0.3
  add cgv_path, priority: 0.3

  # BLOG
  add blog_articles_path
  Article.find_each do |article|
    add blog_article_path(article.slug), lastmod: article.render.updated_at
  end
  
end