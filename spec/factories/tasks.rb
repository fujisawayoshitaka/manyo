FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'Factoryで作ったデフォルトのタイトル１'  }
    content { 'Factoryで作ったデフォルトのコンテント１'  }
    status {'未着手'}
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    status {'未着手'}
  end
  factory :task1, class: Task do
    title { 'タイトル1' }
    content { 'コンテント1' }
    status {'未着手'}
    importance {'低'}
    end_on {'2020/12/12'}
  end
  factory :task2, class: Task do
    title { 'タイトル２' }
    content { 'コンテント２' }
    status {'着手'}
    importance{'中'}
    end_on {'2019/12/12'}
  end
  factory :task3, class: Task do
    title { 'タイトル3' }
    content { 'コンテント3' }
    status {'完了'}
    importance{'高'}
    end_on {'2018/12/12'}
  end
end
