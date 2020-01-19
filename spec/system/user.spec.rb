require 'rails_helper'

RSpec.describe 'ステップ４', type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user2)
    FactoryBot.create(:task, user: user1)
    FactoryBot.create(:task1, user: user1)
    FactoryBot.create(:task2, user: user2)
    visit new_session_path
    fill_in "email", with: "1@gmail.com"
    fill_in "password", with: "yoshitaka1"
    click_button "Log in"
  end

  describe 'ログイン/ログアウト機能のテスト' do
    context "新しいユーザーでサインアップすると" do
      it "　同時にログインできる" do
        click_link 'Logout'
        visit new_user_path
        fill_in 'name', with: "yui"
        fill_in 'email', with: "yui@gmail.com"
        fill_in 'password', with: "password"
        fill_in 'password_confirmation', with: "password"
        click_button "Create my account"
        expect(page).to have_content 'yui'
        expect(page).to have_content 'yui@gmail.com'
        expect(page).to have_content 'Logout'
      end
    end
 end
    context 'ログイン中でユーザー登録のパスを飛ばすと' do
      it 'タスク一覧ページに遷移する' do
        visit new_user_path
        expect(page).to have_text /.*title.*content.*/m
      end
    end
    context 'ログイン中で他人のユーザーページに飛ぼうとすると' do
      it 'タスク一覧ページに遷移する' do
        user = FactoryBot.create(:user2)
        visit user_path(user)
        expect(page).to have_text /.*title.*content.*/m

      end


    end

    context 'ログアウトの状態でタスク一覧のページに遷移しようとすると' do
      it 'ログインページに遷移する' do
        click_link 'Logout'
        expect(page).to have_text /.*email.*password.*/m
      end
    end

    context 'ログインしてタスクを作成してタスク一覧に遷移すると' do
      it '自ら作成したタスクのみ表示される' do
        click_link 'Logout'
        visit new_session_path
        fill_in 'email', with: "2@gmail.com"
        fill_in 'password', with: "yoshitaka2"
        click_button "Create my account"
        visit tasks_path
        expect(page).to have_text /.*タイトル1.*コンテント1.*/m
      end
    end


  end
