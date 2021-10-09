class TagsController < ApplicationController
  def index
    tags = ActsAsTaggableOn::Tag.where('name LIKE ?', "%#{params[:name]}%").pluck(:name).first(5)
    render json: { status: 'SUCCESS', message: 'Loaded tags', data: tags }
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find_by(name: params[:name])
    @tagged_articles = Article.tagged_with(@tag.name)
  end
end
