require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end

  context 'name' do
    it 'should be present' do
      @user.name = ' '
      expect(@user).to_not be_valid
    end
  end

  context 'email' do
    it 'should be present' do
      @user.email = ' '
      expect(@user).to_not be_valid
    end

    it 'should not be too long' do
      @user.email = 'a' * 244 + '@example.com'
      expect(@user).to_not be_valid
    end

    it 'should accept valid addresses' do
      @user.email = 'user@example.com'
      expect(@user).to be_valid
      @user.email = 'USER@foo.COM'
      expect(@user).to be_valid
      @user.email = 'A_US-ER@foo.bar.org'
      expect(@user).to be_valid
      @user.email = 'first.last@foo.jp'
      expect(@user).to be_valid
      @user.email = 'alice+bob@baz.cn'
      expect(@user).to be_valid
    end

    it 'should reject invalid addresses' do
      @user.email = 'user@example,com'
      expect(@user).to_not be_valid
      @user.email = 'user_at_foo.org'
      expect(@user).to_not be_valid
      @user.email = 'user.name@example.'
      expect(@user).to_not be_valid
      @user.email = 'foo@bar_baz.com'
      expect(@user).to_not be_valid
      @user.email = 'foo@bar+baz.com'
      expect(@user).to_not be_valid
    end

    it 'should be unique' do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save!
      expect(duplicate_user).to_not be_valid
    end

    it 'should be saved as lower-case' do
      @user.email = 'Foo@ExAMPle.CoM'
      @user.save!
      expect(@user.reload.email).to eq 'foo@example.com'
    end
  end

  context 'password' do
    it 'validation should accept valid password' do
      @user.password = @user.password_confirmation = 'a' * 6
      expect(@user).to be_valid
    end

    it 'should be present (nonblank)' do
      @user.password = @user.password_confirmation = ' ' * 6
      expect(@user).to_not be_valid
    end

    it 'should have a minimum length' do
      @user.password = @user.password_confirmation = 'a' * 5
      expect(@user).to_not be_valid
    end
  end
end
