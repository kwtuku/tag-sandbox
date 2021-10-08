require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to validate_length_of(:title).is_at_most(50) }
  it { is_expected.to validate_length_of(:body).is_at_most(2000) }

  describe 'validate_tag' do
    context 'when article has no tags' do
      it 'is valid' do
        article = described_class.new(
          title: 'title',
          body: 'body',
          tag_list: ''
        )
        expect(article.valid?).to eq true
      end
    end

    context 'when article has 5 tags' do
      it 'is valid' do
        article = described_class.new(
          title: 'title',
          body: 'body',
          tag_list: 'ruby, php, python, go, c'
        )
        expect(article.valid?).to eq true
      end
    end

    context 'when article has 6 tags' do
      it 'is invalid' do
        article = described_class.new(
          title: 'title',
          body: 'body',
          tag_list: 'ruby, php, python, go, c, java'
        )
        expect(article.invalid?).to eq true
      end
    end
  end
end
