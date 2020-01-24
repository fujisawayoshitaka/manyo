
require 'rails_helper'



RSpec.describe 'タスク管理機能', type: :system do
  #background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    #FactoryBot.create(:task)
    #FactoryBot.create(:second_task)
  #end
  #let(:user){FactoryBot.create(:user)}
  before do
    #user = (:user)
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    FactoryBot.create(:label)
    FactoryBot.create(:label2)
    FactoryBot.create(:user)
    visit new_session_path
    fill_in 'Email', with: '1@gmail.com'
    fill_in 'Password', with: 'yoshitaka1'
    click_button 'Log in'

    click_link 'Taskを作成する'

  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
      # テストで使用するためのタスクを
      # タスク一覧ページに遷移

      #task = FactoryBot.create(:task, title: 'task')
      visit new_task_path

      fill_in 'task_title', with: 'yoshitaka1'
      fill_in 'task_content', with: 'yoshitaka1'

      find("option[value='未着手']").select_option

      click_button '登録する'
      # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
      # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）

      expect(page).to have_content 'yoshitaka1'
      # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        visit new_task_path

        fill_in 'task_title', with: 'yoshitaka2'
        fill_in 'task_content', with: 'yoshitaka2'

        find("option[value='未着手']").select_option

        click_button '登録する'
        visit new_task_path
        fill_in 'task_title', with: 'yoshitaka1'
        fill_in 'task_content', with: 'yoshitaka1'

        find("option[value='未着手']").select_option

        click_button '登録する'
        visit tasks_path
        #byebug
        #byebug
        #task_list = all('.task_row')
        #binding.irb
        # expect(task_list[0]).to have_content 'new_task'
        # expect(task_list[1]).to have_content 'task'
        expect(page).to have_text /.*yoshitaka1.*yoshitaka2.*/m
        # 省略
      end
    end
    context '複数のタスクを作成後、終了期限でソートのタグをクリックすると' do
      it '終了期限の昇順に並んでいること' do
        visit new_task_path

        fill_in 'task_title', with: 'yoshitaka2'
        fill_in 'task_content', with: 'yoshitaka2'

        find("option[value='未着手']").select_option

        click_button '登録する'
        visit new_task_path
        fill_in 'task_title', with: 'yoshitaka1'
        fill_in 'task_content', with: 'yoshitaka1'

        find("option[value='未着手']").select_option

        click_button '登録する'
        visit tasks_path
        click_link '終了期限でソートする'
        #byebug
        #byebug
        #byebug
        #task_list = all('.task_row')
        #binding.irb
        # expect(task_list[0]).to have_content 'new_task'
        # expect(task_list[1]).to have_content 'task'
        expect(page).to have_text /.*yoshitaka2.*yoshitaka1.*/m
      end
    end

    context '複数のタスクを作成後、状態の検索を行うと' do
      it '指定した状態を持ったタスクのみ抽出できること' do

        visit new_task_path

        fill_in 'task_title', with: 'yoshitaka2'
        fill_in 'task_content', with: 'yoshitaka2'

        find("option[value='未着手']").select_option
        click_button '登録する'
        visit new_task_path
        fill_in 'task_title', with: 'yoshitaka1'
        fill_in 'task_content', with: 'yoshitaka1'

        find("option[value='着手']").select_option

        click_button '登録する'
        visit tasks_path
        #byebug
        #task_list = all('.task_row')
        #binding.irb
        #byebug
        # expect(task_list[0]).to have_content 'new_task'
        # expect(task_list[1]).to have_content 'task'
        #byebug
        #select '着手', from: :search
        find("option[value='未着手']").select_option
        click_button '検索'
        expect(page).to have_text '未着手'
        # 省略
      end
    end


  end

  describe 'タスク登録画面' do

    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do

      # new_task_pathにvisitする（タスク登録ページに遷移する）
      # 1.ここにnew_task_pathにvisitする処理を書く
      visit new_task_path
      # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
      # タスクのタイトルと内容をそれぞれfill_in（入力）する
      # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      fill_in 'task_title', with: 'task'
      # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      fill_in 'task_content', with: 'task'
      find("option[value='未着手']").select_option


      # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
      # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く]

      click_button '登録する'
      # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
      # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
      expect(page).to have_content 'task'
      end
    end
  end


  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         visit new_task_path
         fill_in 'task_title', with: 'task'
         # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
         fill_in 'task_content', with: 'task'
         find("option[value='未着手']").select_option
         # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
         # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
         click_button '登録する'
         visit tasks_path

         click_link 'Show'
         expect(page).to have_content 'task'
       end
     end
  end

  describe 'ラベル機能のテスト' do
     context 'ラベルを付与したタスクを作成し' do
       it '該当タスクの詳細ページに遷移するとラベルの内容が記述されている' do
         visit new_task_path

         fill_in 'task_title', with: '1'
         # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
         fill_in 'task_content', with: '1'
         find("option[value='未着手']").select_option
         # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
         # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
         check ("sample1")
         byebug
         click_button '登録する'
         visit tasks_path
         click_link 'Show'
         expect(page).to have_content 'sample1'
       end
     end

     context 'ラベルを付与したタスクを作成し' do
       it '該当タスクの詳細ページに遷移するとラベルの内容が記述されている' do
         visit new_task_path
         fill_in 'task_title', with: '1'
         # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
         fill_in 'task_content', with: '1'
         find("option[value='未着手']").select_option
         # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
         # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
         click_button '登録する'
         visit tasks_path

         click_link 'Show'
         expect(page).to have_content 'task'
       end
     end



  end

end
