require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to validate_length_of(:name).is_at_most(30) }
end
