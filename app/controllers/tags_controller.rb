class TagsController < ApplicationController
  def index
    tags = ActsAsTaggableOn::Tag.where('name LIKE ?', "%#{params[:name]}%").pluck(:name).first(5)
    render json: { status: 'SUCCESS', message: 'Loaded tags', data: tags }
  end

  def show
    @tag = Tag.find_by(name: params[:name])
    raise ActiveRecord::RecordNotFound unless @tag

    @tagged_articles = Article.tagged_with(@tag.name)
  end
end
