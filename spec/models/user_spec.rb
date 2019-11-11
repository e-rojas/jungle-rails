require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { described_class.new(first_name: 'Terry', last_name: 'None', email: 'test@test.com', password: 'test', password_confirmation: 'test') }
  another = User.create(first_name: 'Frank', last_name: 'Another', email: 'TEST@test.com', password: 'test', password_confirmation: 'test')

   describe 'Validations' do
    it "saves a new user" do
      expect(subject).to be_valid
    end

     it "does not save if passwords don't match" do
      subject.password_confirmation = 'tesT'
      expect(subject).to_not be_valid
    end

     it "does not save when emails are the same" do
      expect(subject).to be_valid
      expect(another).to_not be_valid
    end

     it "does not save if password does not exist" do
      subject.password = nil
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

     it "does not save with no first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

     it "does not save with no last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

     it "does not save with no email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

     it "does not save if password doesn't meet minimum length of 4" do
      subject.password = 'REW'
      subject.password_confirmation = 'REW'
      expect(subject).to_not be_valid
    end
  end

   describe '.authenticate_with_credentials' do
    it "logs in with the right info" do
      expect(subject).to be_valid
      subject.save
      expect(User.authenticate_with_credentials(subject.email, subject.password)).to_not eq(nil)
    end

     it "does not log in with the wrong email" do
      expect(subject).to be_valid
      subject.save
      expect(User.authenticate_with_credentials('test', subject.password)).to eq(nil)
    end

     it "does not log in with the wrong password" do
      expect(subject).to be_valid
      subject.save
      expect(User.authenticate_with_credentials(subject.email, 'tesT')).to eq(nil)
    end

     it "logs in with trailing spaces on the email" do
      expect(subject).to be_valid
      subject.save
      expect(User.authenticate_with_credentials(' test@test.com ', subject.password)).to_not eq(nil)
    end

     it "logs in with different casing on the email" do
      expect(subject).to be_valid
      subject.save
      expect(User.authenticate_with_credentials('TesT@test.com', subject.password)).to_not eq(nil)
    end
  end
end
