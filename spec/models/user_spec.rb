require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:user_name)}
    it {should validate_uniqueness_of(:user_name)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}

  end
end
