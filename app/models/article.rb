class Article < ApplicationRecord
  
  # ============= Contentful =============
  # This model is manage on Contentful. 
  # Which mean, the most of the data structure is defined on Contentful space.
  # The fields store in our DB are used to pair our model to Contentful's model.
  # This allow us to work with more efficiency, achieve a continuous delivery
  # for the related models and keep our lovely Rails way working. 
  
  include ContentfulRenderable
  CONTENT_TYPE = "blogPost" # This is content_type_id to match the right model. 
  
  # ============= relationships =============
  # Article(content_type: blogPost) has_one Author(content_type: author)
  # After a Article object is rendered, we can do article.author to get the Author object
  # Just as any Rails model, but everything is on the cloud. 
  
  # ============= validations =============
  
  validates :contentful_id, :slug, presence: true, uniqueness: true
  
  # ============= scopes =============
  
  def self.render_by_categories(categories:, limit: 1000)
    client.entries(
      content_type: self::CONTENT_TYPE, 
      include: 2,
      'fields.categories[in]' => categories,
      limit: limit)
  end
  
  def self.related_articles(categories:, except:)
    client.entries(
      content_type: self::CONTENT_TYPE, 
      include: 2,
      'fields.categories[in]' => categories,
      'sys.id[ne]' => except,
      limit: 5)
  end
  
end