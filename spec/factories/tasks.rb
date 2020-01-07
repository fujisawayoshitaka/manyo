FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'Factoryで作ったデフォルトのタイトル１'  }
    content { 'Factoryで作ったデフォルトのコンテント１'  }
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
  end
end
