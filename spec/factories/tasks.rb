FactoryBot.define do
    factory :task do
      title { '書類作成' }
      content { '企画書を作成する。' }
    end

    factory :first_task, class: Task do
      title { 'メール送信' }
      content { '顧客へ営業のメールを送る。' }
      created_at { '2025/02/18' }
    end
    
    factory :second_task, class: Task do
      title { 'メール送信' }
      content { '顧客へ営業のメールを送る。' }
      created_at { '2025/02/17' }
    end

    factory :third_task, class: Task do
      title { 'メール送信' }
      content { '顧客へ営業のメールを送る。' }
      created_at { '2025/02/16' }
    end
end