
require 'rails_helper'

RSpec.describe 'ステップ４', type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user2)
    FactoryBot.create(:task, user: user1)
    FactoryBot.create(:task1, user: user1)
    FactoryBot.create(:task2, user: user2)
    visit new_session_path
    fill_in "Email", with: "1@gmail.com"
    fill_in "Password", with: "yoshitaka1"
    click_button "Log in"
  end

  describe 'ログイン/ログアウト機能のテスト' do
    context "新しいユーザーでサインアップすると" do
      it "　同時にログインできる" do
        click_link 'Logout'
        visit new_user_path
        fill_in 'user_name', with: "yui"
        fill_in 'user_email', with: "yui@gmail.com"
        fill_in 'user_password', with: "password"
        fill_in 'user_password_confirmation', with: "password"
        click_button "Create my account"
        expect(page).to have_content 'yui'
        expect(page).to have_content 'yui@gmail.com'
        expect(page).to have_content 'Logout'
    end
 end
    context 'ログイン中でユーザー登録のパスを飛ばすと' do
      it 'タスク一覧ページに遷移する' do
        visit new_user_path
        expect(page).to have_text /.*Title.*Content.*/
        expect(page).to have_content 'login中です'
      end
    end
    context 'ログイン中で他人のユーザーページに飛ぼうとすると' do
      it 'タスク一覧ページに遷移する' do
        visit user_path(7)
        expect(page).to have_text "他ユーザーは閲覧できません"


      end


    end

    context 'ログアウトの状態でタスク一覧のページに遷移しようとすると' do
      it 'ログインページに遷移する' do
        click_link 'Logout'
        visit tasks_path
        expect(page).to have_text "loginしてください"
        expect(page).to have_text /.*Email.*Password.*/m
      end
    end

    context 'ログインしてタスクを作成してタスク一覧に遷移すると' do
      it '自ら作成したタスクのみ表示される' do
        click_link 'Logout'
        visit new_session_path
        fill_in 'Email', with: "2@gmail.com"
        fill_in 'Password', with: "yoshitaka2"
        click_button "Log in"
        visit tasks_path

        expect(page).not_to have_text /.*タイトル1.*コンテント1.*/m
      end
     end
    end

    describe 'アドミン機能のテスト' do
      context "ログインユーザーが管理者権限を持ってなければユーザー管理画面に遷移すると" do
        it "タスク一覧画面に遷移し管理者権限がないと通知される" do
          click_link 'Logout'
          visit new_session_path
          fill_in "Email", with: "2@gmail.com"
          fill_in "Password", with: "yoshitaka2"
          click_button "Log in"
          visit tasks_path
          click_link 'user管理ページに遷移する'
          expect(page).to have_text "管理者権限がありません"
        end
      end
    context "管理者権限を持ったユーザーが新規ユーザーを作成すると" do
      it "作成されたユーザーが表示される" do
        visit admin_users_path
        click_link 'userを新規作成する'
        fill_in 'user_name', with: "kana"
        fill_in 'user_email', with: "kana@gmail.com"
        fill_in 'user_password', with: "password"
        fill_in 'user_password_confirmation', with: "password"
        click_button "Create User"
        expect(page).to have_text "kana"
      end
    end

  context "管理者権限を持ったユーザーが新規ユーザーを削除すると" do
    it "削除されたユーザーが表示されなくなる" do
      visit admin_users_path
      click_link 'yoshitaka2'
      click_link 'userを削除する'
      expect(page).not_to have_text "yoshitaka2"
    end
  end

context "管理者権限を持ったユーザーが他ユーザーを編集すると" do
  it "編集されたユーザーが表示される" do
    visit admin_users_path
    click_link 'yoshitaka2'
    click_link 'userを編集する'
    fill_in 'user_name', with: "yoshitaka3"
    fill_in 'user_email', with: "yoshitaka3@gmail.com"
    fill_in 'user_password', with: "yoshitaka3"
    fill_in 'user_password_confirmation', with: "yoshitaka3"
    click_button "Create User"
    expect(page).to have_text "yoshitaka3"
  end
end

context "管理者権限を持ったユーザーを0にしようとすると" do
  it "コールバックされてユーザー一覧ページに遷移して削除できない理由が通知される" do
    visit admin_users_path
    click_link 'yoshitaka1'
    click_link 'userを削除する'
    expect(page).to have_text "管理者ユーザー数は0にはできません"
  end
end






  end

end
