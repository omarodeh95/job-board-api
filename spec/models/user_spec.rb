require 'rails_helper'

describe User, type: :model do

   it 'Not valid without an email' do 
      user = User.create(email: nil, password: "ZeZenZe123123")
      expect(user).to_not be_valid
   end

   it 'Not valid witout a password' do
      user = User.create(email: "omar@outlook.com", password: nil)
      expect(user).to_not be_valid
   end

end