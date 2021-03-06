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
        expect(article).to be_valid
      end
    end

    context 'when article has 5 tags' do
      it 'is valid' do
        article = described_class.new(
          title: 'title',
          body: 'body',
          tag_list: 'ruby, php, python, go, c'
        )
        expect(article).to be_valid
      end
    end

    context 'when article has 6 tags' do
      it 'is invalid' do
        article = described_class.new(
          title: 'title',
          body: 'body',
          tag_list: 'ruby, php, python, go, c, java'
        )
        expect(article).to be_invalid
        expect(article.errors).to be_of_kind(:tag_list, :too_many_tags)
      end
    end

    context 'when tag name length <= 30' do
      it 'is valid' do
        article = described_class.new(
          title: 'title',
          body: 'body',
          tag_list: 'a' * 30
        )
        expect(article).to be_valid
      end
    end

    context 'when tag name length > 30' do
      it 'is invalid' do
        article = described_class.new(
          title: 'title',
          body: 'body',
          tag_list: 'a' * 31
        )
        expect(article).to be_invalid
        expect(article.errors[:tag_list]).to include 'は30文字以内で入力してください'
      end
    end

    context 'when tag name has valid words' do
      let(:valid_tag_names) { %w[ひらがな ゔぁ ヴァ カタカナー 漢字 alphabet ALPHABET 12345] }

      it 'is valid' do
        valid_tag_names.each do |tag_name|
          article = described_class.new(
            title: 'title',
            body: 'body',
            tag_list: tag_name
          )
          expect(article).to be_valid
        end
      end
    end

    context 'when tag name has invalid words' do
      let(:invalid_tag_names) { %w[ｶﾀｶﾅ ｰ ａｌｐｈａｂｅｔ ＡＬＰＨＡＢＥＴ + / ／ * ? '] }

      it 'is invalid' do
        invalid_tag_names.each do |tag_name|
          article = described_class.new(
            title: 'title',
            body: 'body',
            tag_list: tag_name
          )
          expect(article).to be_invalid
          expect(article.errors[:tag_list]).to include 'はひらがな、または全角のカタカナ、漢字、半角の英数字のみが使用できます'
        end
      end
    end
  end

  context 'when tag_list has duplicated words' do
    it 'dose not have duplicated tags' do
      article = described_class.create(
        title: 'title',
        body: 'body',
        tag_list: 'ruby, ruby, Ruby'
      )
      expect(article.tags.map(&:name)).to eq %w[ruby]
    end
  end
end
