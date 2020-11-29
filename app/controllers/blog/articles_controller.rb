class Blog::ArticlesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :verify_content_type, only: [:create]
  before_action :verify_secret, only: [:create]

  def index
    @articles = Article.render_all.sort_by { |a| a.publish_date }.reverse!
  end
  
  def show
    @article = Article.find_by!(slug: params[:id]).render
    @related_articles = Article.related_articles(
      categories: @article.categories, 
      except: @article.id)
  end
  
  def create
    json = JSON.parse(request.body.read)
    contentful_entry_id = json["entryId"]
    contentful_entry = Article.client.entries(
      content_type: Article::CONTENT_TYPE, 
      include: 2, 
      "sys.id" => contentful_entry_id).first
    
    article = Article.new(contentful_id: contentful_entry_id, slug: contentful_entry.slug)
    
    if article.save
      render status: 204, json: "success"
      url = blog_article_url(slug: contentful_entry.slug)
      message = "🖋 Nouvel article publié sur Artiste Entrepreneur : #{contentful_entry.title}.\nVisible à #{url}"
      SlackNotifier.new.perform(message)
    else
      render status: 400, json: article.errors.full_messages.to_sentence
    end
  end
  
  
  private
  
  def verify_content_type
    json = JSON.parse(request.body.read)
    
    unless json["contentType"] == Article::CONTENT_TYPE
      render status: 400, json: "Invalid contentType"
    end
  end
  
  def verify_secret
    unless request.headers["secret"] == ENV["contentful_webhook_secret"]
      render status: 401, json: "Not authorized"
    end
  end
  
end