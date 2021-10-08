class Tag < ActsAsTaggableOn::Tag
  validate :validate_name

  TAG_NAME_MAX_LENGTH = 30
  TAG_NAME_REGEX = /\A[\w一-龠々ぁ-ヶー]+\Z/.freeze
  def validate_name
    errors.add(:name, "は#{TAG_NAME_MAX_LENGTH}文字以内で入力してください") if name.length > TAG_NAME_MAX_LENGTH
    errors.add(:name, 'はひらがな、または全角のカタカナ、漢字、半角の英数字のみが使用できます') unless name.match?(TAG_NAME_REGEX)
  end
end
