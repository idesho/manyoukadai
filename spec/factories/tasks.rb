FactoryBot.define do
    factory :task do
      title { '書類作成' }
      content { '企画書を作成する。' }
      deadline_on { '2025/02/18' }
    priority { 1 }
    status { 0 }
    end

    factory :first_task, class: Task do
      title { 'メール送信' }
      content { '顧客へ営業のメールを送る。' }
      created_at { '2025/02/18' }
      deadline_on { '2025/02/18' }
      priority { 1 }
      status { 0 }
    end
    
    factory :second_task, class: Task do
      title { 'メール送信' }
      content { '顧客へ営業のメールを送る。' }
      created_at { '2025/02/17' }
      deadline_on { '2025/02/17' }
      priority { 2 }
      status { 1 }
    end

    factory :third_task, class: Task do
      title { 'メール送信' }
      content { '顧客へ営業のメールを送る。' }
      created_at { '2025/02/16' }
      deadline_on { '2025/02/16' }
      priority { 0 }
      status { 2 }
    end
end