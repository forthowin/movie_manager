require 'rails_helper'

describe Movie do
  it { should validate_presence_of :title }
  it { should validate_presence_of :format }
  it { should validate_presence_of :length }
  it { should validate_presence_of :release_year }

  it { should validate_length_of(:title).is_at_least(1).is_at_most(50) }
  it { should validate_inclusion_of(:format).in_array(%w(VHS DVD Streaming)) }
  it { should validate_inclusion_of(:length).in_range(1..500).with_message('must be between 1-500') }
  it { should validate_inclusion_of(:release_year).in_range(1800..2100).with_message('must be between 1800-2100') }

  it { should have_many(:collections).dependent(:destroy) }

  describe 'before_save check_cover' do
    it 'sets a default cover if none is uploaded' do
      Fabricate(:movie)
      expect(Movie.first.cover.url).to be_present
    end
  end
end