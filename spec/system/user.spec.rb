require 'spec_helper'
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

    describe 'アドミン機能のテスト' do
      context "ログインユーザーが管理者権限を持ってなければユーザー管理画面に遷移すると" do
        it "タスク一覧画面に遷移し管理者権限がないと通知される" do
          click_link 'Logout'
          visit new_session_path
          fill_in "email", with: "2@gmail.com"
          fill_in "password", with: "yoshitaka2"
          click_button "Log in"
          visit tasks_path
          click_link 'user管理ページに遷移する'
          expect(page).to have_text /.*管理者権限がありません.*/m
    　  end
    end
    context "管理者権限を持ったユーザーが新規ユーザーを作成すると" do
      it "作成されたユーザーが表示される" do
        visit tasks_path
        click_link 'user管理ページに遷移する'

  　  end
  end

  context "管理者権限を持ったユーザーが新規ユーザーを作成すると" do
    it "作成されたユーザーが表示され削除ボタンを押すと" do
      visit new_admin_user_path
      fill_in 'name', with: "yui"
      fill_in 'email', with: "yui@gmail.com"
      fill_in 'password', with: "password"
      fill_in 'password_confirmation', with: "password"
      find("option[value='有効']").select_option
      click_button "Create User"
      expect(page).to have_content 'yui'
      expect(page).to have_content 'yui@gmail.com'
　  end
end

context "管理者権限を持ったユーザーが他ユーザーを編集すると" do
  it "編集されたユーザーが表示される" do
    visit tasks_path
    click_link 'user管理ページに遷移する'

　  end
end






  end

end
