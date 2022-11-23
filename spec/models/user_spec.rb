require 'rails_helper'

RSpec.describe 'ユーザモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: '', email: 'sample@sample.com', password: 'password', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'sample', email: '', password: 'password', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'sample', email: 'sample@sample.com', password: '', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスがすでに使用されていた場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'sample', email: 'sample@sample.com', password: 'password', password_confirmation: 'password')
        user1 = User.create(name: 'sample', email: 'sample@sample.com', password: 'password', password_confirmation: 'password')
        expect(user1).not_to be_valid
      end
    end

    context 'ユーザのパスワードが6文字未満の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'sample', email: 'sample@sample.com', password: 'aa', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザの名前に値があり、メールアドレスが使われていない値で、かつパスワードが6文字以上の場合' do
      it 'バリデーションに成功する' do
        user = User.create(name: 'sample', email: 'sample@sample.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end
    end
  end
end