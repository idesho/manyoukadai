# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # 「task」のように実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを作成されます

  factory :task do

    factory :minitask do
      title { '書類作成' }
      content { '企画書を作成する。' }
      created_at {'2025-02-18'}
      deadline_on {'2025-02-19'}
      priority {'中'}
      status {'未着手'}
    end

    # 作成するテストデータの名前を「second_task」とします
    # 「second_task」のように存在しないクラス名をつける場合、`class`オプションを使ってどのクラスのテストデータを作成するかを明示する必要がります
    factory :email_task do
      title { 'メール送信' }
      content { '顧客へ営業のメールを送る。' }
      created_at {'2025-02-18'}
      deadline_on {'2025-02-19'}
      priority {'中'}
      status {'未着手'}
    end

    factory :first_task do
      title { 'first_task' }
      content { '企画書を作成する。' }
      created_at {'2022-02-18'}
      deadline_on {'2025-02-18'}
      priority {'中'}
      status {'未着手'}
    end

    factory :second_task do
      title { 'second_task' }
      content { '企画書を作成する。' }
      created_at {'2022-02-17'}
      deadline_on {'2025-02-17'}
      priority {'高'}
      status {'着手中'}
    end

    factory :third_task do
      title { 'third_task' }
      content { '企画書を作成する。' }
      created_at {'2022-02-16'}
      deadline_on {'2025-02-16'}
      priority {'低'}
      status {'完了'}
    end

    factory :fainal_task do
      title {"task_title_11"}
      content {"testデータ"}
      deadline_on {"2020-10-10"}
      priority {"高"} 
      status {Task.statuses.values.to_a.sample}
    end

  end
end