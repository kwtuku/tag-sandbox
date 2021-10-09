class Article < ApplicationRecord
  acts_as_taggable_on :tags

  validates :title, length: { maximum: 50 }, presence: true
  validates :body, length: { maximum: 2000 }, presence: true
  validate :validate_tag

  private

  TAG_MAX_COUNT = 5
  def validate_tag
    return errors.add(:tag_list, "は#{TAG_MAX_COUNT}つ以下にしてください") if tag_list.size > TAG_MAX_COUNT

    tag_list.each do |tag_name|
      tag = Tag.new(name: tag_name)
      tag.validate_name
      tag.errors.messages[:name].each { |message| errors.add(:tag_list, message) }
    end
  end
end
