require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task1 = FactoryBot.create(:task1)
    @task2 = FactoryBot.create(:task2)
    @task3 = FactoryBot.create(:task3)
  end

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end

  it 'statusが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', status: '')
    expect(task).not_to be_valid
  end

  it 'importanceが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', importance: '')
    expect(task).not_to be_valid
  end


  it '全ての内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '成功テスト', content: '成功テスト', status: '未着手', importance: '低')
    expect(task).to be_valid
  end

  it '作成順でタスクがソートされているか確認' do
    tasks = Array.new.push(@task3, @task2, @task1)
    expect(Task.desc_created).to eq(tasks)
  end

  it '期限が近い順でタスクがソートされているか確認' do
    tasks = Array.new.push(@task3, @task2, @task1)
    expect(Task.asc_end_on).to eq(tasks)
  end

  it '重要度が高い順でタスクがソートされているか確認' do
    tasks = Array.new.push(@task3, @task2, @task1)
    expect(Task.desc_importance).to eq(tasks)
  end

  it "入力された文字列に当てはまるタイトルを持つタスクがあるか確認" do
    expect(Task.where_like_title("タイトル1")).to include(@task1)
  end

  it "選択された状態に当てはまるタスクを確認" do
    expect(Task.where_like_status("完了")).to include(@task3)
  end

  it "入力された文字列、状態に当てはまるタスクがあるか確認" do
    expect(Task.where_like_status_title("タイトル２", "着手")).to include(@task2)
  end

end
